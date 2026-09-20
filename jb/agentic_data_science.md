# Agentic Data Science

*What happened when a decade-old analysis repository was reorganized, audited, and
re-estimated — and what the audit found.*

---

## The project

Since 2015 I have kept a repository that does one thing: take the
[National Survey of Family Growth](https://www.cdc.gov/nchs/nsfg/index.htm) — a
large, repeated, nationally representative survey run by the National Center for
Health Statistics — and harmonize it across survey cycles so that marriage
patterns can be compared over time.

That is more work than it sounds. The NSFG has run in ten cycles between 1982 and
2022–2023. Each one is published as a fixed-width data file with its own Stata
dictionary, its own variable names, its own coding conventions, and its own
notion of which variables are worth releasing. A variable that exists in one
cycle may be absent from the next, renamed in the one after, or recoded onto a
different scale without changing its name.

The repository grew one cycle at a time. Each new release meant a new reader
function — `ReadFemResp2002`, `ReadFemResp2010`, and so on — that knew the quirks
of that cycle and mapped them onto a common set of columns. Ten cycles for women,
seven for men: seventeen reader functions, each a small archive of things learned
the hard way.

The output is a survival analysis. For each decade-of-birth cohort, it estimates
the fraction who have ever married, as a function of age. Those curves are the
reason the project exists, and they show something clear:

![Percent ever married, women, as published in December 2024](figs/published_2024_marriage_female23.png)

Each successive cohort marries later than the one before, and the more recent
cohorts look likely to end up with a larger share never marrying at all. That
figure, and its male counterpart, appeared in
[a post in December 2024](https://www.allendowney.com/blog/2024/12/11/young-americans-are-marrying-later-or-never/).

## How it accumulated

Eighty-five commits over eleven years, in bursts: seventeen in 2015, then a
handful a year, then a flurry whenever a new cycle landed. Between bursts the
repository sat untouched for months at a time.

This is how a lot of real analysis code lives, and it is worth being honest about
what it looked like after a decade:

- **About 150 files in a single directory.** Raw survey data, derived data, 49
  loose figures, notebooks, and a vendored copy of a 2015-era statistics library,
  all side by side.
- **`git status` reported 78 untracked files and 13 modified ones.** At that point
  the tool stops being useful: a real change is invisible in the noise.
- **Seventeen months of uncommitted work**, including a 1.8 MB notebook that
  produced eleven published figures and had *never been committed at all*.
- **Two parallel codebases.** A modern one using `lifelines` and `empiricaldist`,
  and a legacy one using the vendored library — joined at exactly one function
  call, which kept 116 KB of 2015 code loaded on every run.
- **Data committed to version control.** Several hundred megabytes of survey
  microdata in git-LFS — which, incidentally, NSFG's data user agreement does not
  permit redistributing.

None of this was the result of carelessness. Each piece was a reasonable local
decision: commit the data so the analysis is reproducible; vendor the library so
it does not break; add a reader for the new cycle in the same style as the last
one. The problems are emergent. No single commit introduced them.

## The audit

I recently worked through the repository with Claude, with a simple standing
rule: any change that was supposed to be behavior-preserving had to *prove* it.
Before and after every structural change, the pipeline was re-run and the output
compared — same row counts, same columns, same hash of the whole data frame.

That rule turned out to matter more than any of the cleanup.

### A one-year error in the headline variable

From cycle 10 (2015–2017) onward, the NSFG public-use files stopped publishing
century-month dates of birth and marriage. What they publish instead is the
*year* of first marriage and the *integer* age at interview. The reader functions
reconstructed the missing century months by taking midpoints:

```python
cmbirth  = cmintvw - ager * 12 + 6      # female readers
cmmarrhx = (mardat01 - 1900) * 12 + 6
```

The `+ 6` on the marriage date is right: if you know only the year, mid-year is
the best guess. The `+ 6` on the birth date is not. Someone who reports age
`ager` at interview was born *between* `ager` and `ager + 1` years earlier, so
the midpoint of that window is `- 6`. The `+ 6` places the birth six months
*after* the latest date the reported age allows — not merely biased, but
impossible.

Measured against cycle 9, the last cycle that still publishes a real date of
birth:

| formula | bias | RMSE |
|---|---|---|
| `+6` (female readers) | **+0.998 yr** | 1.039 |
| `0` (male readers) | +0.498 yr | 0.576 |
| `−6` (correct) | **−0.002 yr** | 0.290 |

The consequence: **age at first marriage was a year too low in the three most
recent cycles**, and correct in all the earlier ones. That distorted the trend in
precisely the direction that matters. In the old data, age at first marriage
*fell* between cycle 9 and cycle 10 — from 24.27 to 23.55 for women — a visible
dip suggesting people had started marrying younger again. That dip was entirely
an artifact. Corrected, the series rises monotonically across all ten cycles.

The error survived for years because it hid well. The female and male readers
were wrong in *different* ways that produced the same `agemarry`, so the two
pipelines agreed with each other. And the `+ 6` cancels between `cmbirth` and
`cmmarrhx` when you take the difference — so the headline variable looked
plausible even though the birth dates underneath it were infeasible.

What found it was not reading the code. It was a sweep comparing every derived
variable across every cycle boundary, looking for discontinuities.

## Why the tail is hard

Now the more interesting problem, and the one that took the longest to get right.

A survival curve for a birth cohort answers: of people born in this decade, what
fraction had married by each age? For the 1950s cohort that is easy — everyone in
it has passed age 45, and the survey has observed them doing so.

For the 2000s cohort it is not. In the 2022–2023 survey, the oldest of them are
23. Nobody has been observed at 30. **No estimator can say what fraction of them
will have married by 30**, because no data about it exists. This is
right-censoring, and it is unavoidable — it is a property of time, not of the
method.

What a Kaplan–Meier estimator does at the end of such a cohort's range is
specific and worth understanding. It tracks a *risk set*: the people still
unmarried and still under observation. As age increases, people leave the risk
set by marrying or by running out of observation. Near the end, the risk set
becomes very small. When one person remains and that person marries, the
estimated survival drops to zero — the curve says *100% married* on the strength
of a single respondent.

Look closely at the right-hand end of the 2000s curve in the published figure
above and you can see the machinery straining: short, steep steps where a smooth
curve should be.

### The coarse dates made it much worse

Here is where the missing century months come back.

In the cycles that publish real dates, age at marriage takes about 300 distinct
values and age at interview about 360 — month-level resolution. In cycles 10–12,
age at interview takes **36 distinct values, every one a whole number**, because
the file reports an integer age.

That means every censored respondent in those cycles lands on one of a dozen
integer ages. The risk set does not decline smoothly; it falls off a cliff twelve
times. For the 1990s cohort, **97 people are censored at age 32.000000 exactly**,
dropping the risk set from 131 to 34 in a single instant. Every marriage after
that point moves the curve by 1.3 percentage points instead of 0.1.

So the visible spikes have two causes stacked on each other: a genuinely
exhausted risk set, and an artificial one created by rounding.

### What the pipeline was asserting

Step back and the deeper problem is clearer. The midpoint convention produces a
number — say, age at marriage of 24.83 — and every downstream step treats that as
an exactly observed time. But for cycles 10–12 both endpoints are known only to
the year, so age at first marriage is genuinely uncertain by about **two years**.

The pipeline was reporting to the month a quantity known to within two years. The
spiking tails were a symptom of that, not the disease.

## What we tried

### Option 1: a floor on the risk set

Stop drawing the curve once the risk set falls below some number. This is what
the project was effectively doing, and it works in the narrow sense that the
spikes disappear.

It has two problems. The threshold is arbitrary — I picked 10 because the figures
looked right. And it treats the symptom: the curve still claims month-level
precision everywhere it *is* drawn.

### Option 2: Turnbull's estimator

The textbook answer for interval-censored data is the Turnbull estimator, a
non-parametric maximum likelihood fit that takes an interval per observation
rather than a point. `lifelines` implements it. It is, in a real sense, the
*correct* estimator for data of this shape.

We tried it, and rejected it for two reasons.

It does not fix the tail. On the 2000s cohort it reads 12.88% at age 23.2 and
then jumps to **100%** — the same degeneracy as Kaplan–Meier, for the same
reason. When the risk set is exhausted, the likelihood puts all remaining mass in
the last interval. Being correct about the censoring structure buys nothing once
the data runs out.

And it does not scale. It took 1.1 seconds on a cohort of 2,140 and more than
five minutes on one of 16,169 without finishing. Inside a bootstrap, where it
would run hundreds of times, that is not viable.

### Option 3: multiple imputation

Instead of collapsing each interval to its midpoint, draw a value from inside it.
Draw the birth date uniformly within the year it could have been; draw the
marriage date uniformly within its year; compute age at marriage from the draws.
Repeat.

This is the option we adopted, but the reason is not the one I expected. It does
not smooth the curve — individual draws still spike. What it does is make the
instability *visible*. Five draws for the 2000s cohort gave these final estimates:

**100.00%, 16.86%, 13.16%, 11.54%, 10.58%**

A ninety-point spread on identical data, because at that age the answer turns on
whether one person's imputed marriage date happens to fall before or after their
imputed censoring date. The midpoint convention picks one of those numbers and
reports it without a warning. The imputation reports the spread, which is the
honest answer: *at this age, this data cannot tell you*.

## The rule we settled on

That spread becomes the stopping rule. Fit the curve to many draws, report the
mean, and stop where the draws stop agreeing.

Getting the criterion right took two failures, and both are instructive.

**An absolute threshold does not work.** Stop where the spread exceeds two
percentage points, and a small cohort loses everything: 322 men born in the 1950s
have a bootstrap spread near two points at *every* age, simply because the cohort
is small. The rule truncated that curve at age 21 and discarded it.

**A purely relative threshold does not work either.** Stop where the spread
exceeds three times the cohort's own median, and precision is punished: the 1990s
cohort has a median spread of 0.4 points, so it trips at 1.2 points — an entirely
reportable estimate.

Neither criterion alone separates *"the tail has degenerated"* from *"this cohort
is small"*. Together they do. A point is dropped only if it is anomalous for its
own cohort **and** imprecise in absolute terms:

$$\text{drop where } \; sd > \max(\text{floor},\; k \times \text{median}(sd))$$

The diagnostic below shows it working. Each line is one cohort's bootstrap spread
divided by its own median — solid for women, dashed for men — and the dotted line
is the relative threshold. The 1930s women's curve peaks at 2.2× around age 20
and is *kept*, because in absolute terms it is still precise. The 1990s and 2000s
curves climb past the threshold and are cut.

![Where each estimate stops being reportable](figs/marriage_by_cohort_stopping.png)

## The result

Estimation is now a bootstrap that resamples respondents within cycle by sampling
weight and *then* draws from each respondent's interval, so the spread across
iterations carries sampling variability and date coarseness together.

In the figures below, the shaded band around each curve is a 90% bootstrap
interval, and the dot marks the age past which the data no longer supports an
estimate — the point where the stopping rule cuts the curve off.

![Percent ever married, women, by decade of birth](figs/marriage_by_cohort_female.png)

![Percent ever married, men, by decade of birth](figs/marriage_by_cohort_male.png)

The substantive story is unchanged, and it is worth saying that plainly: each
cohort still marries later than the last, and the recent cohorts still look
likely to end with a larger share never married. An audit that overturned the
finding would be a bigger story; this one did not.

What changed is what the figures claim. The curves stop where the data stops
rather than trailing off into a spike. The bands widen where the estimate is
weak. And each curve carries a dot marking the age past which the data cannot
support an estimate — which is information the old figures did not convey.

The numbers moved too. For women in the 1990s cohort the old pipeline reported
about 62% ever married by age 33; the new one reports 56.5% by 32. Most of that
gap is the censoring correction: retiring people from the risk set half a year
too early removes them before marriages they may have had, which inflates the
estimate.

## What I take from this

**The valuable output was not the cleanup.** Reorganizing 150 files into
directories, purging the data from git history, converting notebooks to markdown,
retiring the vendored library — all worth doing, none of it interesting. The
valuable output was three bugs and a method, and every one of them came from the
same discipline: *check that the thing you believe is true*.

**Verification is what made the agentic part work.** The rule that every
supposedly behavior-preserving change had to produce a byte-identical result is
what made it safe to delete 253 lines of unreachable code, retire a vendored
library, rename 39 functions, and move every file in the repository. It is also
what caught the errors — including two of my collaborator's own, and one of mine
from earlier in the same session.

**Coarsened data deserves explicit handling.** When NSFG stopped publishing
century-month dates, the pipeline papered over it with a midpoint and carried on.
That was the single decision that caused both the year-long bias and the spiking
tails. The honest move — say what you know, which is an interval — was available
the whole time.

**Some questions have no answer, and saying so is the finding.** No estimator can
tell you what fraction of people born in the 2000s will have married by 30. The
best a method can do is be clear about where its knowledge ends. A curve that
stops, with a dot, is more informative than one that continues into a spike.

---

*The code is at [AllenDowney/MarriageNSFG](https://github.com/AllenDowney/MarriageNSFG).
The estimation lives in `nsfg/intervals.py` and `scripts/estimate_marriage.py`;
the figures come from `scripts/plot_marriage.py`.*
