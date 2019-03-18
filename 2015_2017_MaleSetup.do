/**************************************************************************
 |                                                                         
 |           NATIONAL SURVEY OF FAMILY GROWTH (NSFG), 2015-2017
 |
 |                       STATA Male Data Setup File
 |
 |
 |  Please edit this file as instructed below.
 |  To execute, start Stata, change to the directory containing:
 |       - this do file
 |       - the ASCII data file
 |       - the dictionary file
 |
 |  Then execute the do file (e.g., do nsfg_male_setup.do)
 |
 **************************************************************************/


set more off  /* This prevents the Stata output viewer from pausing the
                 process */

/****************************************************

Section 1: File Specifications
   This section assigns local macros to the necessary files.
   Please edit:
        "data-filename" ==> The name of data file downloaded from NCHS
        "dictionary-filename" ==> The name of the dictionary file downloaded.
        "stata-datafile" ==> The name you wish to call your Stata data file.

   Note:  We assume that the raw data, dictionary, and setup (this do file) all
          reside in the same directory (or folder).  If that is not the case
          you will need to include paths as well as filenames in the macros.

********************************************************/

local raw_data "data-filename"
local dict "dictionary-filename"
local outfile "stata-datafile"

/********************************************************

Section 2: Infile Command

This section reads the raw data into Stata format.  If Section 1 was defined
properly, there should be no reason to modify this section.  These macros
should inflate automatically.

**********************************************************/

infile using `dict', using (`raw_data') clear


/*********************************************************

Section 3: Value Label Definitions
This section defines labels for the individual values of each variable.
We suggest that users do not modify this section.

**********************************************************/

label data "National Survey of Family Growth (NSFG), 2015-2017"

#delimit ;
 label define RSCRNINF
   1 "Yes"
   5 "No";

 label define RSCRAGE
  15 "15 years"
  16 "16 years"
  17 "17 years"
  18 "18 years"
  19 "19 years"
  20 "20 years"
  21 "21 years"
  22 "22 years"
  23 "23 years"
  24 "24 years"
  25 "25 years"
  26 "26 years"
  27 "27 years"
  28 "28 years"
  29 "29 years"
  30 "30 years"
  31 "31 years"
  32 "32 years"
  33 "33 years"
  34 "34 years"
  35 "35 years"
  36 "36 years"
  37 "37 years"
  38 "38 years"
  39 "39 years"
  40 "40 years"
  41 "41 years"
  42 "42 years"
  43 "43 years"
  44 "44 years"
  45 "45 years"
  46 "46 years"
  47 "47 years"
  48 "48 years"
  49 "49 years";

 label define RSCRHISP
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define RSCRRACE
   4 "Black or African American"
   5 "White"
   6 "Hispanic"
   8 "Refused"
   9 "Don't know";

 label define AGE_A
  15 "15 years"
  16 "16 years"
  17 "17 years"
  18 "18 years"
  19 "19 years"
  20 "20 years"
  21 "21 years"
  22 "22 years"
  23 "23 years"
  24 "24 years"
  25 "25 years"
  26 "26 years"
  27 "27 years"
  28 "28 years"
  29 "29 years"
  30 "30 years"
  31 "31 years"
  32 "32 years"
  33 "33 years"
  34 "34 years"
  35 "35 years"
  36 "36 years"
  37 "37 years"
  38 "38 years"
  39 "39 years"
  40 "40 years"
  41 "41 years"
  42 "42 years"
  43 "43 years"
  44 "44 years"
  45 "45 years"
  46 "46 years"
  47 "47 years"
  48 "48 years"
  98 "Refused"
  99 "Don't know";

 label define AGE_R
  15 "15 years"
  16 "16 years"
  17 "17 years"
  18 "18 years"
  19 "19 years"
  20 "20 years"
  21 "21 years"
  22 "22 years"
  23 "23 years"
  24 "24 years"
  25 "25 years"
  26 "26 years"
  27 "27 years"
  28 "28 years"
  29 "29 years"
  30 "30 years"
  31 "31 years"
  32 "32 years"
  33 "33 years"
  34 "34 years"
  35 "35 years"
  36 "36 years"
  37 "37 years"
  38 "38 years"
  39 "39 years"
  40 "40 years"
  41 "41 years"
  42 "42 years"
  43 "43 years"
  44 "44 years"
  45 "45 years"
  46 "46 years"
  47 "47 years"
  48 "48 years"
  98 "Refused"
  99 "Don't know";

 label define AGESCRN
  15 "15 years"
  16 "16 years"
  17 "17 years"
  18 "18 years"
  19 "19 years"
  20 "20 years"
  21 "21 years"
  22 "22 years"
  23 "23 years"
  24 "24 years"
  25 "25 years"
  26 "26 years"
  27 "27 years"
  28 "28 years"
  29 "29 years"
  30 "30 years"
  31 "31 years"
  32 "32 years"
  33 "33 years"
  34 "34 years"
  35 "35 years"
  36 "36 years"
  37 "37 years"
  38 "38 years"
  39 "39 years"
  40 "40 years"
  41 "41 years"
  42 "42 years"
  43 "43 years"
  44 "44 years"
  45 "45 years"
  46 "46 years"
  47 "47 years"
  48 "48 years"
  49 "49 years";

 label define HISP
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define HISPGRP
   1 "Mexican, Mexican American, or Chicano, only"
   2 "All other Hispanic or Latino groups, including mulitple responses"
   8 "Refused"
   9 "Don't know";

 label define PRIMLANG1
   1 "English"
   2 "Spanish"
   7 "Other"
   8 "Refused"
   9 "Don't know";

 label define PRIMLANG2
   1 "English"
   2 "Spanish"
   7 "Other"
   8 "Refused"
   9 "Don't know";

 label define PRIMLANG3
   1 "English"
   2 "Spanish"
   7 "Other"
   8 "Refused"
   9 "Don't know";

 label define ROSCNT
   1 "1 HOUSEHOLD MEMBER"
   2 "2 HOUSEHOLD MEMBERS"
   3 "3 HOUSEHOLD MEMBERS"
   4 "4 HOUSEHOLD MEMBERS"
   5 "5 HOUSEHOLD MEMBERS"
   6 "6 HOUSEHOLD MEMBERS"
   7 "7 HOUSEHOLD MEMBERS"
   8 "8 OR MORE HOUSEHOLD MEMBERS"
  98 "Refused"
  99 "Don't know";

 label define MARSTAT
   1 "Married to a person of the opposite sex"
   2 "Not married but living together with a partner of the opposite sex"
   3 "Widowed"
   4 "Divorced or annulled"
   5 "Separated, because you and your spouse are not getting along"
   6 "Never been married"
   8 "Refused"
   9 "Don't know";

 label define FMARSTAT
   3 "Widowed"
   4 "Divorced or annulled"
   5 "Separated, because you and your spouse are not getting along"
   6 "Never been married"
   8 "Refused"
   9 "Don't know";

 label define FMARIT
   0 "DK/RF"
   1 "MARRIED"
   2 "WIDOWED"
   3 "DIVORCED"
   4 "SEPARATED"
   5 "NEVER MARRIED";

 label define EVRMARRY
   0 "NEVER MARRIED"
   1 "EVER MARRIED";

 label define WPLOCALE
   1 "In household"
   2 "Lives elsewhere"
   8 "Refused"
   9 "Don't know";

 label define WOMREL
   1 "WIFE"
   2 "PARTNER";

 label define GOSCHOL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define VACA
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define HIGRADE
   9 "9th grade or less"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1 year of college or less"
  14 "2 years of college"
  15 "3 years of college"
  16 "4 years of college/grad school"
  17 "5 years of college/grad school"
  18 "6 years of college/grad school"
  19 "7 or more years of college and/or grad school"
  98 "Refused"
  99 "Don't know";

 label define COMPGRD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DIPGED
   1 "High school diploma"
   2 "GED only"
   3 "Both"
   5 "Neither"
   8 "Refused"
   9 "Don't know";

 label define EARNHS_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define HISCHGRD
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  98 "Refused"
  99 "Don't know";

 label define LSTGRADE
   0 "No formal schooling"
   9 "9TH GRADE"
  10 "10TH GRADE"
  11 "11TH GRADE"
  12 "12TH GRADE"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define MYSCHOL_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define HAVEDEG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DEGREES
   1 "Associate's degree"
   2 "Bachelor's degree"
   3 "Master's degree"
   4 "Doctorate degree"
   5 "Professional school degree"
   8 "Refused"
   9 "Don't know";

 label define EARNBA_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define EXPSCHL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define EXPGRADE
   9 "9th grade or less"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1 year of college or less"
  14 "2 years of college"
  15 "3 years of college"
  16 "4 years of college/grad school"
  17 "5 years of college/grad school"
  18 "6 years of college/grad school"
  19 "7 or more years of college and/or grad school"
  98 "Refused"
  99 "Don't know";

 label define WTHPARNW
   1 "Both biological or adoptive parents"
   2 "Other or no parental figures"
   8 "Refused"
   9 "Don't know";

 label define ONOWN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define ONOWN18
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define INTACT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PARMARR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define INTACT18
   1 "Yes"
   2 "No"
   8 "Refused"
   9 "Don't know";

 label define LVSIT14F
   1 "Biological mother or adoptive mother"
   2 "Other mother figure"
   3 "No mother figure"
   8 "Refused"
   9 "Don't know";

 label define LVSIT14M
   1 "Biological father or adoptive father"
   2 "Step-father"
   3 "No father figure"
   4 "Other father figure"
   8 "Refused"
   9 "Don't know";

 label define WOMRASDU
   1 "Biological mother"
   2 "Other mother figure"
   3 "No mother figure"
   8 "Refused"
   9 "Don't know";

 label define MOMDEGRE
   1 "Less than high school"
   2 "High school graduate or GED"
   3 "Some college, including 2-year degrees"
   4 "Bachelor's degree or higher"
   8 "Refused"
   9 "Don't know";

 label define MOMWORKD
   1 "Full-time"
   2 "Part-time"
   3 "Equal amounts full-time and part-time"
   4 "Not at all (for pay)"
   8 "Refused"
   9 "Don't know";

 label define MOMFSTCH
   1 "LESS THAN 18 YEARS"
   2 "18-19 YEARS"
   3 "20-24 YEARS"
   4 "25-29 YEARS"
   5 "30 OR OLDER"
  96 "MOTHER-FIGURE HAD NO CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define MOM18
   1 "Under 18"
   2 "18-19"
   3 "20-24"
   4 "25 or older"
   8 "Refused"
   9 "Don't know";

 label define MANRASDU
   1 "Biological father or adoptive father"
   2 "Step-father"
   3 "No father figure"
   4 "Other father figure"
   8 "Refused"
   9 "Don't know";

 label define R_FOSTER
   1 "YES FOSTER"
   3 "NO FOSTER, NOT INTACT"
   5 "NO FOSTER, INTACT";

 label define EVRFSTER
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define MNYFSTER
   1 "1 setting or location"
   2 "2 settings or locations"
   3 "3 settings or locations"
  98 "Refused"
  99 "Don't know";

 label define DURFSTER
   1 "Less than six months"
   2 "At least six months, but less than a year"
   3 "At least a year but less than two years"
   4 "At least two years but less than three years"
   5 "Three years or more"
   8 "Refused"
   9 "Don't know";

 label define TIMESMAR
   1 "1 TIME"
   2 "2 TIMES"
   3 "3 TIMES"
  98 "Refused"
  99 "Don't know";

 label define EVCOHAB1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NUMCOH1
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
  98 "Refused"
  99 "Don't know";

 label define EVCOHAB2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NUMCOH2
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
  98 "Refused"
  99 "Don't know";

 label define EVRCOHAB
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define NUMWIFE
   0 "NEVER MARRIED"
   1 "1 TIME MARRIED"
   2 "2 TIMES MARRIED"
   3 "3 TIMES MARRIED"
 998 "Refused"
 999 "Don't know";

 label define NUMCOHAB
   0 "NO PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
 998 "Refused"
 999 "Don't know";

 label define EVERSEX
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define RHADSEX
   0 "don't know/refused"
   1 "YES"
   2 "NO";

 label define SXMTONCE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define YNOSEX
   1 "Against religion or morals"
   2 "Don't want to get a female pregnant"
   3 "Don't want to get a sexually transmitted disease"
   4 "Haven't found the right person yet"
   5 "In a relationship, but waiting for the right time"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define TALKPAR1
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define TALKPAR2
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define TALKPAR3
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define TALKPAR4
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define TALKPAR5
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define TALKPAR6
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define TALKPAR7
   1 "How to say no to sex"
   2 "Methods of birth control"
   3 "Where to get birth control"
   4 "Sexually transmitted diseases"
   5 "How to prevent HIV/AIDS"
   6 "How to use a condom"
   8 "Waiting until marriage to have sex"
  95 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SEDNO
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDNOG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDNOSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define SEDBC
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDBCLC1
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDBCLC2
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDBCLC3
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDBCLC4
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDBCG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDBCSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define SEDWHBC
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDWHBCG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDWBCSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define SEDCOND
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDCONDG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDCONSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define SEDSTD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDSTDG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDSTDSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define SEDHIV
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDHIVG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDHIVSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define SEDABST
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SEDABLC1
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDABLC2
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDABLC3
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDABLC4
   1 "School"
   2 "Church"
   3 "A community center"
   4 "Some other place"
   8 "Refused"
   9 "Don't know";

 label define SEDABSTG
   1 "1st grade"
   2 "2nd grade"
   3 "3rd grade"
   4 "4th grade"
   5 "5th grade"
   6 "6th grade"
   7 "7th grade"
   8 "8th grade"
   9 "9th grade"
  10 "10th grade"
  11 "11th grade"
  12 "12th grade"
  13 "1st year of college"
  14 "2nd year of college"
  15 "3rd year of college"
  16 "4th year of college"
  96 "Not in school when received instruction"
  98 "Refused"
  99 "Don't know";

 label define SEDABSSX
   1 "Before"
   2 "After"
   8 "Refused"
   9 "Don't know";

 label define EVEROPER
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define TYPEOPER
   1 "Vasectomy"
   2 "Other operation"
   3 "Vasectomy failed"
   4 "Vasectomy already surgically reversed"
   8 "Refused"
   9 "Don't know";

 label define STEROPER
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define VASEC_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define PLCSTROP
   1 "Private doctor's office"
   2 "HMO Facility"
   3 "Community health clinic, community clinic, public health clinic"
   4 "Family planning or Planned Parenthood clinic"
   5 "Employer or company clinic"
   6 "School or school-based clinic"
   7 "Hospital outpatient clinic"
   8 "Hospital emergency room"
   9 "Hospital regular room"
  10 "Urgent care center, urgi-care, or walk-in facility"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define RVRSVAS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define VASREV_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define RSURGSTR
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define FATHPOSS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FATHDIFF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define RSTRSTAT
   0 "NOT STERILE"
   1 "SURGICALLY STERILE"
   2 "NONSURGICALLY STERILE";

 label define LIFEPRT
   1 "One"
   2 "Two"
   3 "Three"
   4 "Four"
   5 "Five"
   6 "Six"
   7 "Seven or more"
   8 "Refused"
   9 "Don't know";

 label define LIFEPRTS
   0 "NONE"
   1 "1 partner"
   2 "2 partners"
   3 "3 partners"
   4 "4 partners"
   5 "5 partners"
   6 "6 partners"
   7 "7 or more partners"
   8 "Refused"
   9 "Don't know";

 label define SXMON12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define MON12PRT
   0 "None"
   1 "One"
   2 "Two"
   3 "Three"
   4 "Four"
   5 "Five"
   6 "Six"
   7 "Seven or more"
   8 "Refused"
   9 "Don't know";

 label define MON12PRTS
   0 "NONE"
   1 "1 partner"
   2 "2 partners"
   3 "3 partners"
   4 "4 partners"
   5 "5 partners"
   6 "6 partners"
   7 "7 or more partners"
   8 "Refused"
   9 "Don't know";

 label define SEXSTAT
   0 "NEVER HAD SEX"
   1 "1 PARTNER EVER/SEX IN LAST 12 MOS/SEX ONLY ONCE"
   2 "1 PARTNER EVER/SEX IN LAST 12 MOS/SEX > ONCE"
   3 "1 PARTNER EVER/NO SEX IN LAST 12 MOS/SEX ONLY ONCE"
   4 "1 PARTNER EVER/NO SEX IN LAST 12 MOS/SEX > ONCE"
   5 ">1 PARTNER EVER/NO SEX IN LAST 12 MOS"
   6 ">1 PARTNER EVER/SEX IN LAST 12 MOS"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define P12MOCONO
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P12MOCON
   1 "Every time"
   2 "Most of the time"
   3 "About half of the time"
   4 "Some of the time"
   5 "None of the time"
   8 "Refused"
   9 "Don't know";

 label define SEXFREQ
   0 "NONE"
   1 "1"
   2 "2"
   3 "3"
   4 "4"
   5 "5"
 998 "Refused"
 999 "Don't know";

 label define CONFREQ
   0 "NONE"
   1 "1"
   2 "2"
   3 "3"
   4 "4"
   5 "5"
 998 "Refused"
 999 "Don't know";

 label define P1RLTN1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P1CURRWIFE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P1CURRSEP
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P1RLTN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P1COHABIT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P1SXLAST_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define P1SXLAST_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMLSXP1
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define P2RLTN1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P2CURRWIFE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P2CURRSEP
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P2RLTN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P2COHABIT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P2SXLAST_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define P2SXLAST_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMLSXP2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define P3RLTN1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P3CURRWIFE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P3CURRSEP
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P3RLTN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P3COHABIT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define P3SXLAST_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define P3SXLAST_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMLSXP3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define P1RELATION
   1 "CURRENT WIFE, NOT SEPARATED"
   2 "CURRENT WIFE, SEPARATED"
   3 "CURRENT COHABITING PARTNER"
   4 "FORMER WIFE"
   5 "FORMER COHABITING PARTNER"
   6 "NEVER IN A MARITAL OR COHAB UNION WITH P"
   8 "Refused"
   9 "Don't know";

 label define P2RELATION
   1 "CURRENT WIFE, NOT SEPARATED"
   2 "CURRENT WIFE, SEPARATED"
   3 "CURRENT COHABITING PARTNER"
   4 "FORMER WIFE"
   5 "FORMER COHABITING PARTNER"
   6 "NEVER IN A MARITAL OR COHAB UNION WITH P"
   8 "Refused"
   9 "Don't know";

 label define P3RELATION
   1 "CURRENT WIFE, NOT SEPARATED"
   2 "CURRENT WIFE, SEPARATED"
   3 "CURRENT COHABITING PARTNER"
   4 "FORMER WIFE"
   5 "FORMER COHABITING PARTNER"
   6 "NEVER IN A MARITAL OR COHAB UNION WITH P"
   8 "Refused"
   9 "Don't know";

 label define FIRST
   1 "Yes, [NAME OF LAST P]"
   2 "Yes, [NAME OF 2ND-TO-LAST P]"
   3 "Yes, [NAME OF 3RD-TO-LAST P]"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define MARRDATE_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define HISAGEM
  98 "Refused"
  99 "Don't know";

 label define LIVTOGWF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTWFCP_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define HISAGEC
  98 "Refused"
  99 "Don't know";

 label define CMSTRTWP
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ENGATHEN
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define WILLMARR
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPDOB_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CWPAGE
  98 "Refused"
  99 "Don't know";

 label define CWPRACE
   1 "Black"
   2 "White"
   3 "Other"
   4 "NA/DK/RF";

 label define CWPNRACE
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define CWPEDUCN
   1 "Less than high school"
   2 "High school graduate or GED"
   3 "Some college but no degree"
   4 "2-year college degree (e.g., Associate's degree)"
   5 "4-year college graduate (e.g., BA, BS)"
   6 "Graduate or professional school"
   8 "Refused"
   9 "Don't know";

 label define CWPBORN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPMARBF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPSX1WN_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define CWPSX1WN_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CWPSX1AG
  98 "Refused"
  99 "Don't know";

 label define CMFSXCWP
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEFSXCWP
  98 "Refused"
  99 "Don't know";

 label define CWPSX1RL
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPFUSE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPFMET01
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPFMET02
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPFMET03
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPFMET04
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPFMET05
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPOPSTR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPTYPOP1
   1 "Tubal ligation or tubal sterilization"
   2 "Hysterectomy"
   3 "Something else"
   8 "Refused"
   9 "Don't know";

 label define CWPTYPOP2
   1 "Tubal ligation or tubal sterilization"
   2 "Hysterectomy"
   3 "Something else"
   8 "Refused"
   9 "Don't know";

 label define CWPTOTST
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPREVST
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PSURGSTR
   0 "NO"
   1 "YES";

 label define CWPPOSS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPDIFF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PSTRSTAT
   0 "NOT STERILE"
   1 "SURGICALLY STERILE"
   2 "NONSURGICALLY STERILE";

 label define CWPLSXWN_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define CWPLSXWN_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMLSXCWP
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CWPLUSE1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPLMET11
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPLMET12
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPLMET13
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPLUSE2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DKCWPLUSE
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define CWPLMET201
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPLMET202
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define DKCWPLMET
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define CWPLSXUSE
   0 "NONE OR NO METHOD IDENTIFIED"
   1 "ANY METHOD IDENTIFIED"
   8 "Refused"
   9 "Don't know";

 label define CWPRECBC
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPALLBC01
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPALLBC02
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPALLBC03
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPALLBC04
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPALLBC05
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CWPBCMST
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define CONDFREQ
 998 "Refused"
 999 "Don't know";

 label define CWPNOFRQ
   1 "Every time"
   2 "Most of the time"
   3 "About half of the time"
   4 "Some of the time"
   5 "None of the time"
   8 "Refused"
   9 "Don't know";

 label define CWPBIOKD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNUMKD
   1 "1 child"
   2 "2 children"
   3 "3 children"
  98 "Refused"
  99 "Don't know";

 label define PARTFATH
   0 "NO"
   1 "YES";

 label define CWPCHSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CWPCHMAR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPCHSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHMAR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN2
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV10
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV11
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE2
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR2
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON2
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN2
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY2
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY2
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPCHSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHMAR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN3
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV19
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV20
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE3
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR3
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON3
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN3
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY3
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY3
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPCHSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHMAR4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN4
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV28
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV29
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE4
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR4
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT4
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON4
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN4
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY4
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY4
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPCHSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHMAR5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN5
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV37
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV38
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE5
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR5
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT5
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON5
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN5
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY5
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY5
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPCHSEX6
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHMAR6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN6
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV46
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV47
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE6
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR6
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT6
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON6
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN6
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY6
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY6
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPCHSEX7
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPCHDOB_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHMAR7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHRES7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLRN7
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define CWPCHLIV55
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHLIV56
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Placed for adoption or adopted"
   8 "Placed in foster care"
   9 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define CWPCHAGE7
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSIG7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHCRT7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHGEN7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHEVR7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPCHFAR7
99998 "Refused"
99999 "Don't know";

 label define CWPCHWNT7
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCHSON7
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPSOONN7
 998 "Refused"
 999 "Don't know";

 label define CWPSOONMY7
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCHHPY7
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CWPPRGNW
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPTRYPG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPTRYLG
 998 "Refused"
 999 "Don't know";

 label define CWPCPWNT
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define CWPCPSON
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define CWPCPSNN
 998 "Refused"
 999 "Don't know";

 label define CWPCPSNMY
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define CWPCPHPY
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define C_OKAKIDS
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define CWPOTKID
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKNUM
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define CWPOKWTH
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKWTHN
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define CWPOKSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPOKAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTRY
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTHR
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKFAR
99998 "Refused"
99999 "Don't know";

 label define CWPOKAGE
  98 "Refused"
  99 "Don't know";

 label define CWPOKSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPOKAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTRY2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTHR2
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV8
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKFAR2
99998 "Refused"
99999 "Don't know";

 label define CWPOKAGE2
  98 "Refused"
  99 "Don't know";

 label define CWPOKSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPOKAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTRY3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTHR3
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV15
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV16
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKFAR3
99998 "Refused"
99999 "Don't know";

 label define CWPOKAGE3
  98 "Refused"
  99 "Don't know";

 label define CWPOKSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPOKAD4
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTRY4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTHR4
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV22
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV23
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKFAR4
99998 "Refused"
99999 "Don't know";

 label define CWPOKAGE4
  98 "Refused"
  99 "Don't know";

 label define CWPOKSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPOKAD5
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTRY5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPOKTHR5
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV29
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKLIV30
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPOKFAR5
99998 "Refused"
99999 "Don't know";

 label define CWPOKAGE5
  98 "Refused"
  99 "Don't know";

 label define C_NBAKIDS
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define CWPNBEVR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBNUM
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV3
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL2
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR2
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV8
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV10
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR2
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE2
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL3
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR3
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV15
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV16
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV17
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR3
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE3
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL4
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD4
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR4
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV22
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV23
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV24
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR4
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE4
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL5
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD5
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR5
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV29
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV30
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV31
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR5
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE5
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL6
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX6
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD6
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR6
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV36
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV37
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV38
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR6
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE6
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL7
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX7
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD7
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR7
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV43
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV44
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV45
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR7
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE7
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL8
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX8
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD8
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR8
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV50
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV51
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV52
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR8
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE8
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL9
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX9
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD9
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR9
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV57
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV58
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV59
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR9
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE9
  98 "Refused"
  99 "Don't know";

 label define CWPNBREL10
   1 "Yes, by blood"
   3 "Yes, by marriage"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFOS10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBSEX10
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define CWPNBAD10
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTRY10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CWPNBTHR10
   1 "Yes, trying to adopt"
   3 "Yes, trying to become guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV64
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV65
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBLIV66
   1 "In this household full-time"
   2 "In this household part-time"
   3 "Away at school or college"
   4 "Living on own"
   5 "Living with other relatives"
   6 "Deceased"
   7 "Someplace else"
   8 "Refused"
   9 "Don't know";

 label define CWPNBFAR10
99998 "Refused"
99999 "Don't know";

 label define CWPNBAGE10
  98 "Refused"
  99 "Don't know";

 label define MARDATEN_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARR
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV
  98 "Refused"
  99 "Don't know";

 label define CMUNIONP
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ENGAGTHN
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDATEN_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARR2
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV2
  98 "Refused"
  99 "Don't know";

 label define ENGAGTHN2
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND2
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDATEN_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARR3
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV3
  98 "Refused"
  99 "Don't know";

 label define ENGAGTHN3
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND3
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CURRPRTS
   0 "INAPP/DK/RF"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   8 "Refused"
   9 "Don't know";

 label define PXCURR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCURRPRT
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define PXMARRY
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXCURR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCURRPRT2
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define PXMARRY2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXCURR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCURRPRT3
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define PXMARRY3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXLRUSE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXLRMETH1
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLRMETH2
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLRMETH3
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPUSE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DKPXLPUSE
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define PXLPMETH01
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPMETH02
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPMETH03
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define DKPXLPMETH
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define LSXUSEP
   0 "NONE OR NO METHOD IDENTIFIED"
   1 "ANY METHOD IDENTIFIED"
   8 "Refused"
   9 "Don't know";

 label define MTONCEP
   0 "NOT ASCERTAINED"
   1 "YES (MORE THAN ONCE)"
   2 "NO (ONCE)";

 label define PXLSXPRB
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXMTONCE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXFRLTN1
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define P1YRACE1
   1 "Black"
   2 "White"
   3 "Other"
   4 "NA/DK/RF";

 label define P1YNRACE1
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define PXLRUSE2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXLRMETH5
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLRMETH6
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLRMETH7
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPUSE2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DKPXLPUSE2
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define PXLPMETH11
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPMETH12
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPMETH13
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define DKPXLPMETH2
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define LSXUSEP2
   0 "NONE OR NO METHOD IDENTIFIED"
   1 "ANY METHOD IDENTIFIED"
   8 "Refused"
   9 "Don't know";

 label define MTONCEP2
   0 "NOT ASCERTAINED"
   1 "YES (MORE THAN ONCE)"
   2 "NO (ONCE)";

 label define PXLSXPRB2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXMTONCE2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXFRLTN3
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define P1YRACE2
   1 "Black"
   2 "White"
   3 "Other"
   4 "NA/DK/RF";

 label define P1YNRACE2
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define PXLRUSE3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXLRMETH9
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLRMETH10
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLRMETH11
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
  10 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPUSE3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DKPXLPUSE3
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define PXLPMETH21
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPMETH22
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXLPMETH23
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define DKPXLPMETH3
   1 "Don't recall"
   2 "Never knew"
   8 "Refused"
   9 "Don't know";

 label define LSXUSEP3
   0 "NONE OR NO METHOD IDENTIFIED"
   1 "ANY METHOD IDENTIFIED"
   8 "Refused"
   9 "Don't know";

 label define MTONCEP3
   0 "NOT ASCERTAINED"
   1 "YES (MORE THAN ONCE)"
   2 "NO (ONCE)";

 label define PXLSXPRB3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXMTONCE3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXFRLTN5
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define P1YRACE3
   1 "Black"
   2 "White"
   3 "Other"
   4 "NA/DK/RF";

 label define P1YNRACE3
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define PXDOB_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define PXEDUC
   1 "Less than high school"
   2 "High school graduate or GED"
   3 "Some college but no degree"
   4 "2-year college degree (e.g., Associate's degree)"
   5 "4-year college graduate (e.g., BA, BS)"
   6 "Graduate or professional school"
   8 "Refused"
   9 "Don't know";

 label define PXMARBF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXANYCH
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXANYCHN
   1 "1 CHILD"
   2 "2 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define PXABLECH
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXDOB_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define PXEDUC2
   1 "Less than high school"
   2 "High school graduate or GED"
   3 "Some college but no degree"
   4 "2-year college degree (e.g., Associate's degree)"
   5 "4-year college graduate (e.g., BA, BS)"
   6 "Graduate or professional school"
   8 "Refused"
   9 "Don't know";

 label define PXMARBF2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXANYCH2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXANYCHN2
   1 "1 CHILD"
   2 "2 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define PXABLECH2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXDOB_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define PXEDUC3
   1 "Less than high school"
   2 "High school graduate or GED"
   3 "Some college but no degree"
   4 "2-year college degree (e.g., Associate's degree)"
   5 "4-year college graduate (e.g., BA, BS)"
   6 "Graduate or professional school"
   8 "Refused"
   9 "Don't know";

 label define PXMARBF3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXANYCH3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXANYCHN3
   1 "1 CHILD"
   2 "2 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define PXABLECH3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXSXFRST_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define PXSXFRST_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMFSXP
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEFSXP
9998 "Refused"
9999 "Don't know";

 label define PXAGFRST
  98 "Refused"
  99 "Don't know";

 label define PXFRLTN2
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFUSE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXFMETH01
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH02
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH03
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH04
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXSXFRST_M2
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define PXSXFRST_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMFSXP2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEFSXP2
9998 "Refused"
9999 "Don't know";

 label define PXAGFRST2
  98 "Refused"
  99 "Don't know";

 label define PXFRLTN4
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFUSE2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXFMETH14
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH15
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH16
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH17
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXSXFRST_M3
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define PXSXFRST_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMFSXP3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEFSXP3
9998 "Refused"
9999 "Don't know";

 label define PXAGFRST3
  98 "Refused"
  99 "Don't know";

 label define PXFRLTN6
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFUSE3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXFMETH27
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH28
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH29
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXFMETH30
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXANYUSE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXMETHOD01
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD02
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD03
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD04
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD05
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMSTUSE
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXCONFRQ
 998 "Refused"
 999 "Don't know";

 label define PXNOFREQ
   1 "Every time"
   2 "Most of the time"
   3 "About half of the time"
   4 "Some of the time"
   5 "None of the time"
   8 "Refused"
   9 "Don't know";

 label define PXANYUSE2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXMETHOD14
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD15
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD16
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD17
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD18
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMSTUSE2
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXCONFRQ2
 998 "Refused"
 999 "Don't know";

 label define PXNOFREQ2
   1 "Every time"
   2 "Most of the time"
   3 "About half of the time"
   4 "Some of the time"
   5 "None of the time"
   8 "Refused"
   9 "Don't know";

 label define PXANYUSE3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXMETHOD27
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD28
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD29
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD30
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMETHOD31
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXMSTUSE3
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define PXCONFRQ3
 998 "Refused"
 999 "Don't know";

 label define PXNOFREQ3
   1 "Every time"
   2 "Most of the time"
   3 "About half of the time"
   4 "Some of the time"
   5 "None of the time"
   8 "Refused"
   9 "Don't know";

 label define PXCHILD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCHILDN
   1 "1 child"
   2 "2 children"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV01
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV02
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV03
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR
99998 "Refused"
99999 "Don't know";

 label define PXWANT
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW2
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV11
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV12
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV13
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE2
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR2
99998 "Refused"
99999 "Don't know";

 label define PXWANT2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON2
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN2
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY2
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG2
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW3
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV21
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV22
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV23
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE3
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR3
99998 "Refused"
99999 "Don't know";

 label define PXWANT3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON3
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN3
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY3
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG3
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW4
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV31
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV32
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV33
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE4
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR4
99998 "Refused"
99999 "Don't know";

 label define PXWANT4
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON4
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN4
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY4
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG4
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCHILD2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCHILDN2
   1 "1 child"
   2 "2 children"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX11
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y11
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW11
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV101
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV102
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE11
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR11
99998 "Refused"
99999 "Don't know";

 label define PXWANT11
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON11
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN11
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY11
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG11
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX12
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y12
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW12
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV111
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV112
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE12
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR12
99998 "Refused"
99999 "Don't know";

 label define PXWANT12
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON12
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN12
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY12
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG12
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX13
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y13
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW13
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV121
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV122
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE13
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR13
99998 "Refused"
99999 "Don't know";

 label define PXWANT13
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON13
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN13
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY13
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG13
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX14
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y14
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW14
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV131
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV132
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE14
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR14
99998 "Refused"
99999 "Don't know";

 label define PXWANT14
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON14
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN14
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY14
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG14
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCHILD3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCHILDN3
   1 "1 child"
   2 "2 children"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX21
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y21
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT31
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW21
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV201
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV202
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE21
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR21
99998 "Refused"
99999 "Don't know";

 label define PXWANT21
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON21
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN21
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY21
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG21
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX22
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y22
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT32
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW22
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV211
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV212
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE22
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR22
99998 "Refused"
99999 "Don't know";

 label define PXWANT22
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON22
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN22
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY22
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG22
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX23
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y23
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT33
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW23
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV221
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV222
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE23
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR23
99998 "Refused"
99999 "Don't know";

 label define PXWANT23
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON23
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN23
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY23
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG23
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX24
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y24
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT34
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW24
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV231
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV232
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE24
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER24
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR24
99998 "Refused"
99999 "Don't know";

 label define PXWANT24
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON24
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN24
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY24
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG24
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCXSEX25
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXCXBORN_Y25
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT35
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXMARB25
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXRES25
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXKNOW25
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define PXCXLIV241
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXLIV242
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXCXAGE25
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define PXCXSIG25
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXCRT25
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXGEN25
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXEVER25
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXCXFAR25
99998 "Refused"
99999 "Don't know";

 label define PXWANT25
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXSOON25
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXSOONN25
 998 "Refused"
 999 "Don't know";

 label define PXSOONMY25
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXHPYPG25
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCPREG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXTRYING
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXTRYLONG
 998 "Refused"
 999 "Don't know";

 label define PXRWANT
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXRSOON
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXRSOONN
 998 "Refused"
 999 "Don't know";

 label define PXRSOONMY
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXCPFEEL
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCPREG2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXTRYING2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXTRYLONG2
 998 "Refused"
 999 "Don't know";

 label define PXRWANT2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXRSOON2
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXRSOONN2
 998 "Refused"
 999 "Don't know";

 label define PXRSOONMY2
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXCPFEEL2
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define PXCPREG3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXTRYING3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXTRYLONG3
 998 "Refused"
 999 "Don't know";

 label define PXRWANT3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PXRSOON3
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define PXRSOONN3
 998 "Refused"
 999 "Don't know";

 label define PXRSOONMY3
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define PXCPFEEL3
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CURRPREG
   0 "INAPP/DK/RF"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define D_OKAKIDS
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXOTKID
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXOKNUM
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXOKWTH
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXOKWTHN
   1 "1 child"
   2 "2 children"
   3 "3 children"
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR2
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE2
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV17
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR3
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE3
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD4
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV25
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR4
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE4
  98 "Refused"
  99 "Don't know";

 label define D_OKAKIDS2
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXOTKID2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXOKNUM2
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXOKWTH2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXOKWTHN2
   1 "1 child"
   2 "2 children"
   3 "3 children"
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX11
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD11
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV81
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR11
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE11
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX12
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD12
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV89
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR12
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE12
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX13
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD13
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV97
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR13
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE13
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX14
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD14
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV105
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR14
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE14
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX15
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD15
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKLIV113
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXOKFAR15
99998 "Refused"
99999 "Don't know";

 label define PXOKAGE15
  98 "Refused"
  99 "Don't know";

 label define D_OKAKIDS3
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXOTKID3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXOKNUM3
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXOKWTH3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXOKWTHN3
   1 "1 child"
   2 "2 children"
   3 "3 children"
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX21
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD21
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKAGE21
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX22
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD22
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKAGE22
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX23
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD23
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKAGE23
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX24
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD24
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKAGE24
  98 "Refused"
  99 "Don't know";

 label define PXOKSEX25
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXOKAD25
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXOKAGE25
  98 "Refused"
  99 "Don't know";

 label define D_NBAKIDS
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXNBEVR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBNUM
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXNBREL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXNBLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXNBFAR
99998 "Refused"
99999 "Don't know";

 label define PXNBAGE
  98 "Refused"
  99 "Don't know";

 label define PXNBREL2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXNBLIV10
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXNBFAR2
99998 "Refused"
99999 "Don't know";

 label define PXNBAGE2
  98 "Refused"
  99 "Don't know";

 label define PXNBREL3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBLIV17
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXNBLIV18
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define PXNBFAR3
99998 "Refused"
99999 "Don't know";

 label define PXNBAGE3
  98 "Refused"
  99 "Don't know";

 label define D_NBAKIDS2
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXNBEVR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBNUM2
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXNBREL11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX11
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD11
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE11
  98 "Refused"
  99 "Don't know";

 label define PXNBREL12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX12
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD12
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE12
  98 "Refused"
  99 "Don't know";

 label define PXNBREL13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX13
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD13
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE13
  98 "Refused"
  99 "Don't know";

 label define PXNBREL14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX14
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD14
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE14
  98 "Refused"
  99 "Don't know";

 label define PXNBREL15
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS15
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX15
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD15
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE15
  98 "Refused"
  99 "Don't know";

 label define PXNBREL16
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS16
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX16
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD16
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE16
  98 "Refused"
  99 "Don't know";

 label define PXNBREL17
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS17
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX17
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD17
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE17
  98 "Refused"
  99 "Don't know";

 label define PXNBREL18
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBFOS18
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PXNBSEX18
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define PXNBAD18
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define PXNBAGE18
  98 "Refused"
  99 "Don't know";

 label define D_NBAKIDS3
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define PXNBEVR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FPFIRST_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define FPFIRST_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMFSTSEX
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FSTSEXAGE
  98 "Refused"
  99 "Don't know";

 label define FPAGE
  98 "Refused"
  99 "Don't know";

 label define FPAGE18
   1 "Less than 18"
   2 "18 years or older"
   8 "Refused"
   9 "Don't know";

 label define FPAGE15
   1 "Less than 15"
   2 "15 years or older"
   8 "Refused"
   9 "Don't know";

 label define FPAGE20
   1 "Less than 20"
   2 "20 years or older"
   8 "Refused"
   9 "Don't know";

 label define RFSXAGEGP
   0 "0"
   1 "Less than 15"
   2 "15 or older but less than 18"
   3 "18 or older but less than 20"
   4 "20 or older";

 label define FPRLTN
   1 "Married to her"
   2 "Engaged to her, and living together"
   3 "Engaged to her, but not living together"
   4 "Living together in a sexual relationship, but not engaged"
   5 "Going with her or going steady"
   6 "Going out with her once in a while"
   7 "Just friends"
   8 "Had just met her"
   9 "Something else"
  98 "Refused"
  99 "Don't know";

 label define FPUSE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FPMETH01
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define FPMETH02
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define FPMETH03
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define FPMETH04
   1 "Condom or rubber"
   2 "Withdrawal or pulling out"
   3 "Vasectomy or male sterilization"
   4 "Pill"
   5 "Tubal sterilization or other female sterilization"
   6 "Injection (Depo-Provera or Lunelle)"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant (Norplant, Implanon or Nexplanon)"
   9 "Rhythm or safe period"
  10 "Contraceptive patch (Ortho-Evra)"
  11 "Vaginal contraceptive ring (Nuva Ring)"
  12 "IUD, coil, or loop"
  13 "Something else"
  98 "Refused"
  99 "Don't know";

 label define FPPROBE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NFORMWIFE
   0 "NONE"
   1 "1 FORMER WIFE"
   2 "2 FORMER WIVES"
   3 "3 FORMER WIVES"
   4 "4 FORMER WIVES"
 998 "Refused"
 999 "Don't know";

 label define NFORMCOHAB
   0 "NONE"
   1 "1 FORMER COHABITING PARTNER"
   2 "2 FORMER COHABITING PARTNERS"
 998 "Refused"
 999 "Don't know";

 label define FWVERIFY
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWVER
   0 "NO"
   1 "YES";

 label define FWVERIFY2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWVER2
   0 "NO"
   1 "YES";

 label define FWVERIFY3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWVER3
   0 "NO"
   1 "YES";

 label define FWVERIFY4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWVER4
   0 "NO"
   1 "YES";

 label define FCVER
   0 "NO"
   1 "YES";

 label define FCVERIFY
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define EXRELATION
   0 "FORMER COHAB PARTNER"
   1 "FORMER WIFE"
   8 "Refused"
   9 "Don't know";

 label define FWMAREND_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARRN
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV4
  98 "Refused"
  99 "Don't know";

 label define CMUNIONW
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ENGAGTHN4
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND4
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define EXRELATION2
   0 "FORMER COHAB PARTNER"
   1 "FORMER WIFE"
   8 "Refused"
   9 "Don't know";

 label define FWMAREND_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARRN2
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV5
  98 "Refused"
  99 "Don't know";

 label define ENGAGTHN5
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND5
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define EXRELATION3
   0 "FORMER COHAB PARTNER"
   1 "FORMER WIFE"
   8 "Refused"
   9 "Don't know";

 label define FWMAREND_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARRN3
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV6
  98 "Refused"
  99 "Don't know";

 label define ENGAGTHN6
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND6
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define EXRELATION4
   0 "FORMER COHAB PARTNER"
   1 "FORMER WIFE"
   8 "Refused"
   9 "Don't know";

 label define FWMAREND_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGEMARRN4
  98 "Refused"
  99 "Don't know";

 label define LIVTOGN7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV7
  98 "Refused"
  99 "Don't know";

 label define ENGAGTHN7
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define MARREND7
   1 "Death of wife"
   2 "Divorce"
   3 "Annulment"
   4 "Separation"
   8 "Refused"
   9 "Don't know";

 label define WIFEDIED_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define DIVORFIN_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define ANNULLED_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define STOPLIVE_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define EXRELATION11
   0 "FORMER COHAB PARTNER"
   1 "FORMER WIFE"
   8 "Refused"
   9 "Don't know";

 label define STRTLIVE_Y14
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMCOHFC11
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define AGELIV14
  98 "Refused"
  99 "Don't know";

 label define ENGAGTHN14
   1 "YES, ENGAGED TO BE MARRIED"
   3 "NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
   5 "NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
   8 "REFUSED"
   9 "DON'T KNOW";

 label define STOPLIVE_Y14
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPDOB_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPAGE
  98 "Refused"
  99 "Don't know";

 label define WIF1RACE
   1 "Black"
   2 "White"
   3 "Other"
   4 "NA/DK/RF";

 label define WIF1NRACE
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define FWPMARBF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPDOB_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPAGE2
  98 "Refused"
  99 "Don't know";

 label define FWPMARBF2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPDOB_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPAGE3
  98 "Refused"
  99 "Don't know";

 label define FWPMARBF3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPDOB_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPAGE4
  98 "Refused"
  99 "Don't know";

 label define FWPMARBF4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPDOB_Y11
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPAGE11
  98 "Refused"
  99 "Don't know";

 label define COH1RACE
   1 "Black"
   2 "White"
   3 "Other"
   4 "NA/DK/RF";

 label define COH1NRACE
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define FWPMARBF11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPBIOKD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNUMKD
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWCHMARB
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV01
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV02
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV03
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT42
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN2
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV11
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV12
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV13
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE2
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR2
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON2
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN2
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY2
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG2
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT43
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN3
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV21
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV22
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV23
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE3
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR3
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON3
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN3
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY3
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG3
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT44
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN4
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV31
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV32
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV33
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE4
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR4
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT4
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON4
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN4
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY4
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG4
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT45
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN5
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV41
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV42
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV43
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE5
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR5
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT5
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON5
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN5
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY5
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG5
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPBIOKD2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNUMKD2
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX11
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y11
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWCHMARB11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN11
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV101
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV102
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE11
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR11
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT11
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON11
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN11
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY11
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG11
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX12
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y12
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT52
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN12
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV111
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV112
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE12
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR12
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT12
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON12
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN12
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY12
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG12
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX13
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y13
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT53
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN13
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV121
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV122
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE13
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR13
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR13
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT13
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON13
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN13
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY13
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG13
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX14
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y14
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT54
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN14
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV131
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV132
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE14
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR14
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR14
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT14
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON14
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN14
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY14
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG14
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPBIOKD3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNUMKD3
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX21
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y21
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWCHMARB21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN21
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV201
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV202
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE21
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR21
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT21
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON21
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN21
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY21
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG21
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX22
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y22
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT62
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN22
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV211
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV212
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE22
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR22
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT22
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON22
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN22
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY22
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG22
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX23
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y23
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT63
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWCHMARB23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN23
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV221
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV222
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE23
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR23
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR23
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT23
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON23
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN23
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY23
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG23
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPBIOKD4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNUMKD4
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define FWPBIOKD11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNUMKD11
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX101
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y101
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FWPCHRES101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN101
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV1001
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1002
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1003
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE101
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR101
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT101
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON101
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN101
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY101
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG101
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX102
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y102
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT142
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN102
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV1011
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1012
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1013
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE102
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR102
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT102
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON102
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN102
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY102
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG102
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX103
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y103
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT143
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN103
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV1021
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1022
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1023
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE103
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR103
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT103
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON103
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN103
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY103
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG103
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define FWPCHSEX104
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPCHDOB_Y104
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT144
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHRES104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLRN104
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define FWPCHLIV1031
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1032
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHLIV1033
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPCHAGE104
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define FWPCHSIG104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHCRT104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHGEN104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHEVR104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPCHFAR104
99998 "Refused"
99999 "Don't know";

 label define FWPRWANT104
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define FWPSOON104
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define FWPSOONN104
 998 "Refused"
 999 "Don't know";

 label define FWPSOONMY104
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define FWPHPYPG104
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define E_OKAKIDS
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPOTKID
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKNUM
  98 "Refused"
  99 "Don't know";

 label define FWPOKWTH
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKWTHN
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKLIV10
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR2
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE2
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV17
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKLIV18
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR3
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE3
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD4
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV25
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKLIV26
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR4
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE4
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD5
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV33
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKLIV34
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR5
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE5
  98 "Refused"
  99 "Don't know";

 label define E_OKAKIDS2
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPOTKID2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKNUM2
  98 "Refused"
  99 "Don't know";

 label define FWPOKWTH2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKWTHN2
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX11
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD11
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV81
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR11
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE11
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX12
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD12
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV89
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR12
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE12
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX13
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD13
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV97
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR13
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE13
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX14
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD14
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV105
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR14
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE14
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX15
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD15
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV113
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR15
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE15
  98 "Refused"
  99 "Don't know";

 label define E_OKAKIDS3
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPOTKID3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKNUM3
  98 "Refused"
  99 "Don't know";

 label define FWPOKWTH3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKWTHN3
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX21
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD21
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV161
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR21
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE21
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX22
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD22
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV169
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR22
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE22
  98 "Refused"
  99 "Don't know";

 label define E_OKAKIDS4
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPOTKID4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKNUM4
  98 "Refused"
  99 "Don't know";

 label define FWPOKWTH4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKWTHN4
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX31
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD31
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAGE31
  98 "Refused"
  99 "Don't know";

 label define E_OKAKIDS11
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPOTKID11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKNUM11
  98 "Refused"
  99 "Don't know";

 label define FWPOKWTH11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPOKWTHN11
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX101
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD101
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV801
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR101
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE101
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX102
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD102
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV809
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR102
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE102
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX103
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD103
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV817
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR103
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE103
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX104
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD104
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV825
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR104
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE104
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX105
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD105
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV833
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR105
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE105
  98 "Refused"
  99 "Don't know";

 label define FWPOKSEX106
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPOKAD106
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPOKLIV841
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPOKFAR106
99998 "Refused"
99999 "Don't know";

 label define FWPOKAGE106
  98 "Refused"
  99 "Don't know";

 label define E_NBAKIDS
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPNBEVR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBNUM
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBLIV10
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR2
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE2
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV17
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBLIV18
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR3
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE3
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD4
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV25
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBLIV26
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR4
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE4
  98 "Refused"
  99 "Don't know";

 label define E_NBAKIDS2
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPNBEVR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBNUM2
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX11
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD11
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV81
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR11
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE11
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX12
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD12
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV89
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR12
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE12
  98 "Refused"
  99 "Don't know";

 label define E_NBAKIDS3
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPNBEVR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBNUM3
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS21
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX21
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD21
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV161
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR21
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE21
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS22
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX22
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD22
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV169
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR22
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE22
  98 "Refused"
  99 "Don't know";

 label define E_NBAKIDS4
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPNBEVR4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define E_NBAKIDS11
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define FWPNBEVR11
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBNUM11
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS101
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX101
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD101
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV801
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR101
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE101
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS102
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX102
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD102
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV809
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR102
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE102
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS103
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX103
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD103
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV817
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR103
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE103
  98 "Refused"
  99 "Don't know";

 label define FWPNBREL104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBFOS104
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define FWPNBSEX104
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define FWPNBAD104
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define FWPNBLIV825
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define FWPNBFAR104
99998 "Refused"
99999 "Don't know";

 label define FWPNBAGE104
  98 "Refused"
  99 "Don't know";

 label define OTBCHIL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTBPROBE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTBCHILN
   1 "1 child"
   2 "2 children"
   3 "3 children"
  98 "Refused"
  99 "Don't know";

 label define OTBSAME
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCSEXX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define OBCMAGEX
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX01
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX02
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX03
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT152
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX2
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX2
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX11
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX12
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX13
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE2
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR2
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX2
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN2
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY2
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX2
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT153
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX3
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX3
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX21
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX22
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX23
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE3
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR3
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX3
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN3
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY3
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX3
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT154
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX4
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX4
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX31
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX32
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX33
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE4
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR4
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX4
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX4
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN4
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY4
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX4
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT155
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX5
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX5
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX41
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX42
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX43
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE5
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR5
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX5
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX5
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN5
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY5
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX5
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX6
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT156
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX6
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX6
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX51
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX52
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX53
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE6
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR6
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX6
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX6
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN6
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY6
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX6
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX7
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT157
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX7
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX7
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX61
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX62
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX63
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE7
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR7
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX7
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX7
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN7
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY7
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX7
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX8
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y8
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT158
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX8
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX8
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX71
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX72
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX73
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE8
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR8
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX8
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX8
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN8
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY8
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX8
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX9
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y9
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT159
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX9
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX9
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX81
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX82
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX83
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE9
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR9
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX9
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX9
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN9
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY9
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX9
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define OBCSEXX10
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OBCDOB_Y10
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MULTBIRT160
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCMAGEX10
  98 "Refused"
  99 "Don't know";

 label define OBCMLIV10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCKNOWX10
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define OBCLIVEX91
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX92
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCLIVEX93
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OBCAGE10
   1 "Less than 5 years old"
   2 "5-18 years old"
   3 "19 years or older"
   8 "Refused"
   9 "Don't know";

 label define OBCCHSIG10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHCRT10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCCHGEN10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCEVER10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OBCFAR10
99998 "Refused"
99999 "Don't know";

 label define OBCRWANX10
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONX10
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define OBCSOONN10
 998 "Refused"
 999 "Don't know";

 label define OBCSOONMY10
   1 "Months"
   2 "Years"
   8 "Refused"
   9 "Don't know";

 label define OBCHPYX10
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define F_AKIDS
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define OTACHIL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTACHILN
   1 "1 child"
  98 "Refused"
  99 "Don't know";

 label define OTNBREL
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV1
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV2
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE
  98 "Refused"
  99 "Don't know";

 label define OTNBREL2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD2
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV9
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV10
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR2
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE2
  98 "Refused"
  99 "Don't know";

 label define OTNBREL3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD3
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV17
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV18
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR3
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE3
  98 "Refused"
  99 "Don't know";

 label define OTNBREL4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD4
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV25
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV26
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR4
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE4
  98 "Refused"
  99 "Don't know";

 label define OTNBREL5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD5
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV33
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV34
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR5
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE5
  98 "Refused"
  99 "Don't know";

 label define OTNBREL6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX6
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD6
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV41
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV42
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR6
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE6
  98 "Refused"
  99 "Don't know";

 label define OTNBREL7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX7
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD7
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV49
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV50
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR7
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE7
  98 "Refused"
  99 "Don't know";

 label define OTNBREL8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBFOS8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTNBSEX8
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define OTNBAD8
   1 "Yes, adopted"
   3 "Yes, became guardian"
   5 "No, neither"
   8 "Refused"
   9 "Don't know";

 label define OTNBLIV57
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBLIV58
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her biological parent(s)"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define OTNBFAR8
99998 "Refused"
99999 "Don't know";

 label define OTNBAGE8
  98 "Refused"
  99 "Don't know";

 label define OTPREG
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTPRGPRB
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define OTPRGN
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
  98 "Refused"
  99 "Don't know";

 label define OTPRGEND
   1 "Miscarriage"
   2 "Stillbirth"
   3 "Abortion"
   8 "Refused"
   9 "Don't know";

 label define OTMSN
   0 "NONE"
  98 "Refused"
  99 "Don't know";

 label define OTSTN
   0 "NONE"
  98 "Refused"
  99 "Don't know";

 label define OTABN
   0 "NONE"
  98 "Refused"
  99 "Don't know";

 label define TOTPRG
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
   3 "3 PREGNANCIES"
   4 "4 PREGNANCIES"
   5 "5 PREGNANCIES"
  98 "Refused"
  99 "Don't know";

 label define OTPREGS
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
  98 "Refused"
  99 "Don't know";

 label define TOTPREGS_C
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
   3 "3 PREGNANCIES"
   4 "4 PREGNANCIES"
   5 "5 PREGNANCIES"
 998 "Refused"
 999 "Don't know";

 label define TOTPREGS_R
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
   3 "3 PREGNANCIES"
   4 "4 PREGNANCIES"
   5 "5 PREGNANCIES"
 998 "Refused"
 999 "Don't know";

 label define BIOKIDS
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN";

 label define ADOPKIDS
   0 "None"
  98 "Refused"
  99 "Don't know";

 label define ANYKIDS
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOADOPT
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN";

 label define PREGSNOW
   0 "INAPP/DK/RF"
   1 "1 woman"
   2 "2 women"
   3 "3 women"
  98 "Refused"
  99 "Don't know";

 label define NUMLIFE
  50 "50 OR MORE PARTNERS"
 998 "Refused"
 999 "Don't know";

 label define BIODOB1
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB2
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB3
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB4
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB5
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB6
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB7
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB8
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB9
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIODOB10
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define BIOSEX1
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX2
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX3
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX4
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX5
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX6
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX7
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX8
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX9
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOSEX10
   1 "Male"
   2 "Female"
   8 "Refused"
   9 "Don't know";

 label define BIOAGE1
 998 "Refused"
 999 "Don't know";

 label define BIOAGE2
 998 "Refused"
 999 "Don't know";

 label define BIOAGE3
 998 "Refused"
 999 "Don't know";

 label define BIOAGE4
 998 "Refused"
 999 "Don't know";

 label define BIOAGE5
 998 "Refused"
 999 "Don't know";

 label define BIOAGE6
 998 "Refused"
 999 "Don't know";

 label define BIOAGE7
 998 "Refused"
 999 "Don't know";

 label define BIOAGE8
 998 "Refused"
 999 "Don't know";

 label define BIOAGE9
 998 "Refused"
 999 "Don't know";

 label define BIOAGE10
 998 "Refused"
 999 "Don't know";

 label define BIOAGEGP1
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP2
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP3
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP4
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP5
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP6
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP7
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP8
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP9
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOAGEGP10
   1 "Under 5 years"
   2 "5-18 years"
   3 "19 or older"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BIOHH1
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH2
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH3
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH4
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH5
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH6
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH7
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH8
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH9
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOHH10
   1 "In household"
   2 "Alive, not adopted/foster, but not in HH"
   3 "Dead or adopted/foster or DK/RF"
   8 "Refused"
   9 "Don't know";

 label define BIOMOM1
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM2
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM3
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM4
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM5
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM6
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM7
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM8
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM9
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMOM10
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define BIOMAR1
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR2
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR3
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR4
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR5
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR6
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR7
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR8
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR9
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOMAR10
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB1
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB2
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB3
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB4
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB5
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB6
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB7
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB8
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB9
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOCOHB10
   0 "NO"
   1 "YES"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG1
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG2
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG3
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG4
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG5
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG6
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG7
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG8
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG9
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLRNPG10
   1 "During the pregnancy"
   2 "After the child was born"
   8 "Refused"
   9 "Don't know";

 label define BIOLIVNG11
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG12
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG13
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG21
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG22
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG23
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG31
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG32
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG33
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG41
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG42
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG43
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG51
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG52
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG53
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG61
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG62
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG63
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG71
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG72
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG73
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG81
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG82
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG83
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG91
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG92
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG93
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG101
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG102
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOLIVNG103
   1 "In this household full-time"
   2 "In this household part-time"
   3 "With his/her mother"
   4 "Away at school or college"
   5 "Living on own"
   6 "Living with other relatives"
   7 "Deceased"
   8 "Placed for adoption or adopted"
   9 "Placed in foster care"
  10 "Someplace else"
  98 "Refused"
  99 "Don't know";

 label define BIOCHSIG1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHSIG10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHCRT10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOCHGEN10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR1
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR2
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR3
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR4
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR5
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR6
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR7
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR8
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR9
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOLVEVR10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BIOHWFAR1
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR2
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR3
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR4
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR5
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR6
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR7
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR8
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR9
99998 "Refused"
99999 "Don't know";

 label define BIOHWFAR10
99998 "Refused"
99999 "Don't know";

 label define BIOWANT1
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT2
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT3
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT4
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT5
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT6
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT7
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT8
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT9
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOWANT10
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON1
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON2
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON3
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON4
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON5
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON6
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON7
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON8
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON9
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHSOON10
   1 "Too soon"
   2 "Right time"
   3 "Later"
   4 "Didn't care"
   8 "Refused"
   9 "Don't know";

 label define BIOHOWSN1
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN2
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN3
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN4
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN5
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN6
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN7
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN8
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN9
 998 "Refused"
 999 "Don't know";

 label define BIOHOWSN10
 998 "Refused"
 999 "Don't know";

 label define BIOHPYPG1
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG2
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG3
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG4
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG5
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG6
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG7
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG8
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG9
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define BIOHPYPG10
   0 "Very unhappy"
   5 "5"
  10 "Very happy"
  98 "Refused"
  99 "Don't know";

 label define CRALL
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
   4 "4 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define CRALLU5
   0 "NONE"
   1 "1 CHILD"
   2 "2 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define CRALL518
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define CRMALU5
   0 "NONE"
   1 "1 CHILD"
   2 "2 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define CRMAL518
   0 "NONE"
   1 "1 CHILD"
   2 "2 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define CRFEMU5
   0 "NONE"
   1 "1 CHILD"
   2 "2 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define CRFEM518
   0 "NONE"
   1 "1 CHILD"
   2 "2 OR MORE CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define NCALL
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define NCALLU5
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define NCALL518
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define NCMALU5
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define NCMAL518
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define NCFEMU5
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define NCFEM518
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define RFAGE
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define RFSEX
   1 "Male"
   2 "Female"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define ROUTG04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RMEAL04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RERRAND04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RPLAY04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RREAD04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RAFFECT04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RPRAISE04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RFEED04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RBATH04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RDIAPER04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RBED04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RAPPT04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RDISC04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ROUTG518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RMEAL518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RERRAND518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RAFFECT518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RPRAISE518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RTAKE518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RAPPT518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RHELP518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RDISC518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RCLFR518
   1 "Knows everything"
   2 "Knows most things"
   3 "Knows some things"
   4 "Knows a little"
   5 "Knows nothing"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RDO518
   1 "Knows everything"
   2 "Knows most things"
   3 "Knows some things"
   4 "Knows a little"
   5 "Knows nothing"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRFAGE
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define NRFSEX
   1 "Male"
   2 "Female"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define NRVISIT04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRSATVIS04
   0 "Very dissatisfied"
   1 "1"
   2 "2"
   3 "3"
   4 "4"
   5 "5"
   6 "6"
   7 "7"
   8 "8"
   9 "9"
  10 "Very satisfied"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define NROUTG04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRMEAL04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRERRAND04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NROVRNT04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRPLAY04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRREAD04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRAFFECT04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRPRAISE04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRFEED04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRBATH04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRDIAPER04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRBED04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRAPPT04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRDISC04
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRVISIT518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRSATVIS518
   0 "Very dissatisfied"
   1 "1"
   2 "2"
   3 "3"
   4 "4"
   5 "5"
   6 "6"
   7 "7"
   8 "8"
   9 "9"
  10 "Very satisfied"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define NROUTG518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRMEAL518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRERRAND518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NROVRNT518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRAFFECT518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRPRAISE518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRTAKE518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRAPPT518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRHELP518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRDISC518
   1 "Not at all"
   2 "Less than once a week"
   3 "About once a week"
   4 "Several times a week"
   5 "Every day (at least once a day)"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRCLFR518
   1 "Knows everything"
   2 "Knows most things"
   3 "Knows some things"
   4 "Knows a little"
   5 "Knows nothing"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRDO518
   1 "Knows everything"
   2 "Knows most things"
   3 "Knows some things"
   4 "Knows a little"
   5 "Knows nothing"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NRMONEY
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NREG
   1 "Regular basis"
   2 "Once in a while"
   8 "Refused"
   9 "Don't know";

 label define NRAGREE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NRCHSUPPYR
   0 "none/amt not reported"
   1 "1-3000"
   2 "3001-5000"
   3 "5001-9000"
   4 "9001+";

 label define COPARENT
   1 "Strongly agree"
   2 "Agree"
   3 "Disagree"
   4 "Strongly disagree"
   5 "If R insists: Neither agree nor disagree"
   8 "Refused"
   9 "Don't know";

 label define RWANT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define PROBWANT
   1 "Probably want"
   2 "Probably do not want"
   8 "Refused"
   9 "Don't know";

 label define JINTEND
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define JSUREINT
   1 "Very sure"
   2 "Somewhat sure"
   3 "Not at all sure"
   8 "Refused"
   9 "Don't know";

 label define JINTENDN
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define JEXPECTL
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define JEXPECTS
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define JINTNEXT
   1 "Within the next 2 years"
   2 "2-5 years from now"
   3 "More than 5 years from now"
   8 "Refused"
   9 "Don't know";

 label define INTEND
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define INTENDN
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define EXPECTL
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
  98 "Refused"
  99 "Don't know";

 label define EXPECTS
   0 "NONE"
   1 "1 CHILD"
  98 "Refused"
  99 "Don't know";

 label define INTNEXT
   1 "Within the next 2 years"
   2 "2-5 years from now"
   3 "More than 5 years from now"
   8 "Refused"
   9 "Don't know";

 label define USUALCAR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define USLPLACE
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define USL12MOS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CURRCOV
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define COVERHOW01
   1 "Private health insurance plan (from employer or workplace; purchased directly; through a state or local government program or community program)"
   2 "Medicaid-additional name(s) for Medicaid in this state: [MEDICAID_FILL]"
   3 "Medicare"
   4 "Medi-GAP"
   5 "Military health care including: the VA, CHAMPUS, TRICARE, CHAMP-VA"
   6 "Indian Health Service, or Single Service Plan"
   7 "CHIP"
   8 "State-sponsored health plan"
   9 "Other government health care"
  98 "Refused"
  99 "Don't know";

 label define COVERHOW02
   1 "Private health insurance plan (from employer or workplace; purchased directly; through a state or local government program or community program)"
   2 "Medicaid-additional name(s) for Medicaid in this state: [MEDICAID_FILL]"
   3 "Medicare"
   4 "Medi-GAP"
   5 "Military health care including: the VA, CHAMPUS, TRICARE, CHAMP-VA"
   6 "Indian Health Service, or Single Service Plan"
   7 "CHIP"
   8 "State-sponsored health plan"
   9 "Other government health care"
  98 "Refused"
  99 "Don't know";

 label define COVERHOW03
   1 "Private health insurance plan (from employer or workplace; purchased directly; through a state or local government program or community program)"
   2 "Medicaid-additional name(s) for Medicaid in this state: [MEDICAID_FILL]"
   3 "Medicare"
   4 "Medi-GAP"
   5 "Military health care including: the VA, CHAMPUS, TRICARE, CHAMP-VA"
   6 "Indian Health Service, or Single Service Plan"
   7 "CHIP"
   8 "State-sponsored health plan"
   9 "Other government health care"
  98 "Refused"
  99 "Don't know";

 label define COVERHOW04
   1 "Private health insurance plan (from employer or workplace; purchased directly; through a state or local government program or community program)"
   2 "Medicaid-additional name(s) for Medicaid in this state: [MEDICAID_FILL]"
   3 "Medicare"
   4 "Medi-GAP"
   5 "Military health care including: the VA, CHAMPUS, TRICARE, CHAMP-VA"
   6 "Indian Health Service, or Single Service Plan"
   7 "CHIP"
   8 "State-sponsored health plan"
   9 "Other government health care"
  98 "Refused"
  99 "Don't know";

 label define PARINSUR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define INS_EXCH
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define INS_PREM
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define COVER12
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NUMNOCOV
   1 "1 Month"
   2 "2 Months"
   3 "3 Months"
   4 "4 Months"
   5 "5 Months"
   6 "6 Months"
   7 "7 Months"
   8 "8 Months"
   9 "9 Months"
  10 "10 Months"
  11 "11 Months"
  12 "12 Months"
  98 "Refused"
  99 "Don't know";

 label define YOUGOFPC
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define WHENGOFP
   1 "In the last 12 months"
   2 "More than 12 months ago"
   8 "Refused"
   9 "Don't know";

 label define YOUFPSVC1
   1 "Physical exam"
   2 "Information or advice on birth control methods, including condoms"
   3 "HIV testing"
   4 "Testing for sexually transmitted infection other than HIV"
   5 "Treatment for sexually transmitted infection other than HIV"
   6 "Some other service"
   8 "Refused"
   9 "Don't know";

 label define YOUFPSVC2
   1 "Physical exam"
   2 "Information or advice on birth control methods, including condoms"
   3 "HIV testing"
   4 "Testing for sexually transmitted infection other than HIV"
   5 "Treatment for sexually transmitted infection other than HIV"
   6 "Some other service"
   8 "Refused"
   9 "Don't know";

 label define YOUFPSVC3
   1 "Physical exam"
   2 "Information or advice on birth control methods, including condoms"
   3 "HIV testing"
   4 "Testing for sexually transmitted infection other than HIV"
   5 "Treatment for sexually transmitted infection other than HIV"
   6 "Some other service"
   8 "Refused"
   9 "Don't know";

 label define YOUFPSVC4
   1 "Physical exam"
   2 "Information or advice on birth control methods, including condoms"
   3 "HIV testing"
   4 "Testing for sexually transmitted infection other than HIV"
   5 "Treatment for sexually transmitted infection other than HIV"
   6 "Some other service"
   8 "Refused"
   9 "Don't know";

 label define YOUFPSVC5
   1 "Physical exam"
   2 "Information or advice on birth control methods, including condoms"
   3 "HIV testing"
   4 "Testing for sexually transmitted infection other than HIV"
   5 "Treatment for sexually transmitted infection other than HIV"
   6 "Some other service"
   8 "Refused"
   9 "Don't know";

 label define YOUFPSVC6
   1 "Physical exam"
   2 "Information or advice on birth control methods, including condoms"
   3 "HIV testing"
   4 "Testing for sexually transmitted infection other than HIV"
   5 "Treatment for sexually transmitted infection other than HIV"
   6 "Some other service"
   8 "Refused"
   9 "Don't know";

 label define DEAF
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BLIND
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DIFDECIDE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DIFWALK
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DIFDRESS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define DIFOUT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define EVRCANCER
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define AGECANCER
  98 "Refused"
  99 "Don't know";

 label define CANCTYPE
   1 "Bladder cancer"
   2 "Bone cancer"
   3 "Brain cancer or tumor, spinal cord cancer, or other cancer of the central nervous system"
   4 "Breast cancer"
   5 "BLANK"
   6 "Colon cancer"
   7 "BLANK"
   8 "Head and neck cancer"
   9 "Heart cancer"
  10 "Leukemia/blood cancer"
  11 "Liver cancer"
  12 "Lung cancer"
  13 "Lymphoma including Hodgkins disease/Lymphoma and non-Hodgkins lymphomas"
  14 "Melanoma"
  15 "Neuroblastoma"
  16 "Oral (mouth/tongue/lip) cancer"
  17 "BLANK"
  18 "Pancreatic (pancreas) cancer"
  19 "Pharyngeal (throat) cancer"
  20 "Prostate cancer"
  21 "Rectal (rectum) cancer"
  22 "Renal (kidney) cancer"
  23 "Stomach cancer"
  24 "Thyroid cancer"
  25 "Other"
  26 "Blood"
  27 "Esophageal (esophagus) cancer"
  29 "Gallbladder cancer"
  30 "Laryngeal (larynx/windpipe) cancer"
  31 "Skin cancer (non-melanoma)"
  32 "Skin cancer (DK what kind)"
  33 "Soft tissue (muscle or fat) sarcoma"
  34 "Testicular (testis) cancer"
  98 "Refused"
  99 "Don't know";

 label define ALCORISK
   1 "A lot"
   2 "A little"
   3 "Not at all"
   4 "No opinion"
   8 "Refused"
   9 "Don't know";

 label define VISIT12MO1
   1 "A routine physical exam"
   2 "A physical exam for sports or work"
   3 "A doctor visit when you were sick or hurt"
   4 "Did not have any visits to a doctor"
   8 "Refused"
   9 "Don't know";

 label define VISIT12MO2
   1 "A routine physical exam"
   2 "A physical exam for sports or work"
   3 "A doctor visit when you were sick or hurt"
   4 "Did not have any visits to a doctor"
   8 "Refused"
   9 "Don't know";

 label define VISIT12MO3
   1 "A routine physical exam"
   2 "A physical exam for sports or work"
   3 "A doctor visit when you were sick or hurt"
   4 "Did not have any visits to a doctor"
   8 "Refused"
   9 "Don't know";

 label define SVC12MO1
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO2
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO3
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO4
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO5
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO6
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO7
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define SVC12MO8
   1 "A testicular exam (had your testicles examined)"
   2 "Testing for sexually transmitted disease"
   3 "Treatment for sexually transmitted disease"
   4 "Information or advice about using condoms"
   5 "Information or advice about your partner using female methods of birth control"
   6 "Information or advice about you getting a vasectomy (surgically sterilized)"
   7 "Information or advice about HIV or AIDS"
   8 "Information or advice about other sexually transmitted infections, such as gonorrhea, Chlamydia, syphilis, or genital herpes"
   9 "None of the above"
  98 "Refused"
  99 "Don't know";

 label define NUMVISIT
   1 "1 VISIT"
   2 "2 VISITS"
   3 "3 VISITS"
   4 "4 VISITS"
  98 "Refused"
  99 "Don't know";

 label define PLACEVIS01
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define PLACEVIS02
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define PLACEVIS03
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define PLACEVIS04
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define PLACEVIS05
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define PLACEVIS06
   1 "Private doctor's office or HMO"
   2 "Community health clinic, community clinic, public health clinic"
   3 "Family planning or Planned Parenthood Clinic"
   4 "Employer or company clinic"
   5 "School or school-based clinic"
   6 "Hospital outpatient clinic"
   7 "Hospital emergency room"
   8 "Hospital regular room"
   9 "Urgent care center, urgi-care, or walk-in facility"
  10 "Sexually transmitted disease (STD) clinic"
  11 "In-store health clinic (like CVS, Target, or Walmart)"
  20 "Some other place"
  98 "Refused"
  99 "Don't know";

 label define SVCPAY1
   1 "Insurance"
   2 "Co-payment"
   3 "Out-of-pocket payment (not including copay)"
   4 "Medicaid"
   5 "No payment required"
   6 "Some other way"
   8 "Refused"
   9 "Don't know";

 label define SVCPAY2
   1 "Insurance"
   2 "Co-payment"
   3 "Out-of-pocket payment (not including copay)"
   4 "Medicaid"
   5 "No payment required"
   6 "Some other way"
   8 "Refused"
   9 "Don't know";

 label define SVCPAY3
   1 "Insurance"
   2 "Co-payment"
   3 "Out-of-pocket payment (not including copay)"
   4 "Medicaid"
   5 "No payment required"
   6 "Some other way"
   8 "Refused"
   9 "Don't know";

 label define SVCPAY4
   1 "Insurance"
   2 "Co-payment"
   3 "Out-of-pocket payment (not including copay)"
   4 "Medicaid"
   5 "No payment required"
   6 "Some other way"
   8 "Refused"
   9 "Don't know";

 label define SVCPAY5
   1 "Insurance"
   2 "Co-payment"
   3 "Out-of-pocket payment (not including copay)"
   4 "Medicaid"
   5 "No payment required"
   6 "Some other way"
   8 "Refused"
   9 "Don't know";

 label define TALKSA
   1 "Yes"
   5 "No"
   7 "If vol: Provider already knew R's status"
   8 "Refused"
   9 "Don't know";

 label define TALKEC
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define TALKDM
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define WHYPSTD
   1 "Could walk in or get same-day appointment"
   2 "Cost"
   3 "Privacy concern"
   4 "Expert care here"
   5 "Embarrassed to go to usual provider"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define BARRIER1
   1 "I did not need to see a doctor in the last year"
   2 "I did not know where to go for care"
   3 "I could not afford to pay for a visit"
   4 "I was afraid to hear bad news"
   5 "I had privacy/confidentiality concerns"
   6 "I could not take time off from work"
   7 "Insurance"
   8 "Not sexually active"
   9 "Time/busy"
  10 "Didn't make appt"
  11 "Don't like/trust doctors"
  20 "Something else - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define BARRIER2
   1 "I did not need to see a doctor in the last year"
   2 "I did not know where to go for care"
   3 "I could not afford to pay for a visit"
   4 "I was afraid to hear bad news"
   5 "I had privacy/confidentiality concerns"
   6 "I could not take time off from work"
   7 "Insurance"
   8 "Not sexually active"
   9 "Time/busy"
  10 "Didn't make appt"
  11 "Don't like/trust doctors"
  20 "Something else - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define BARRIER3
   1 "I did not need to see a doctor in the last year"
   2 "I did not know where to go for care"
   3 "I could not afford to pay for a visit"
   4 "I was afraid to hear bad news"
   5 "I had privacy/confidentiality concerns"
   6 "I could not take time off from work"
   7 "Insurance"
   8 "Not sexually active"
   9 "Time/busy"
  10 "Didn't make appt"
  11 "Don't like/trust doctors"
  20 "Something else - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define BARRIER4
   1 "I did not need to see a doctor in the last year"
   2 "I did not know where to go for care"
   3 "I could not afford to pay for a visit"
   4 "I was afraid to hear bad news"
   5 "I had privacy/confidentiality concerns"
   6 "I could not take time off from work"
   7 "Insurance"
   8 "Not sexually active"
   9 "Time/busy"
  10 "Didn't make appt"
  11 "Don't like/trust doctors"
  20 "Something else - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define BLDPRESS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define HIGHBP
   1 "Yes"
   5 "No"
   6 "If vol: Not told results"
   8 "Refused"
   9 "Don't know";

 label define BPMEDS
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define ASKSMOKE
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define INFHELP
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define INFSVCS1
   1 "Advice"
   2 "Infertility testing"
   3 "Drugs to improve ovulation"
   4 "Surgery to correct blocked tubes"
   5 "Artificial insemination"
   6 "Treatment for varicocele"
   7 "Other types of medical help"
   8 "Refused"
   9 "Don't know";

 label define INFSVCS2
   1 "Advice"
   2 "Infertility testing"
   3 "Drugs to improve ovulation"
   4 "Surgery to correct blocked tubes"
   5 "Artificial insemination"
   6 "Treatment for varicocele"
   7 "Other types of medical help"
   8 "Refused"
   9 "Don't know";

 label define INFSVCS3
   1 "Advice"
   2 "Infertility testing"
   3 "Drugs to improve ovulation"
   4 "Surgery to correct blocked tubes"
   5 "Artificial insemination"
   6 "Treatment for varicocele"
   7 "Other types of medical help"
   8 "Refused"
   9 "Don't know";

 label define INFSVCS4
   1 "Advice"
   2 "Infertility testing"
   3 "Drugs to improve ovulation"
   4 "Surgery to correct blocked tubes"
   5 "Artificial insemination"
   6 "Treatment for varicocele"
   7 "Other types of medical help"
   8 "Refused"
   9 "Don't know";

 label define INFSVCS5
   1 "Advice"
   2 "Infertility testing"
   3 "Drugs to improve ovulation"
   4 "Surgery to correct blocked tubes"
   5 "Artificial insemination"
   6 "Treatment for varicocele"
   7 "Other types of medical help"
   8 "Refused"
   9 "Don't know";

 label define INFSVCS6
   1 "Advice"
   2 "Infertility testing"
   3 "Drugs to improve ovulation"
   4 "Surgery to correct blocked tubes"
   5 "Artificial insemination"
   6 "Treatment for varicocele"
   7 "Other types of medical help"
   8 "Refused"
   9 "Don't know";

 label define INFTEST
   1 "You"
   2 "Her"
   3 "Both of you"
   8 "Refused"
   9 "Don't know";

 label define WHOINSEM
   1 "You only"
   2 "Some other donor only"
   3 "Both"
   8 "Refused"
   9 "Don't know";

 label define INFHLPNW
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define LASTVIS_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  98 "Refused"
  99 "Don't know";

 label define LASTVIS_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMINFVIS
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define INFRTHIS_1
   1 "Low sperm count or no sperm"
   2 "Varicocele"
   3 "Genetic disorder that alters sperm production"
   4 "Low testosterone level"
   5 "Other"
   6 "None of the above"
   8 "Refused"
   9 "Don't know";

 label define INFRTHIS_2
   1 "Low sperm count or no sperm"
   2 "Varicocele"
   3 "Genetic disorder that alters sperm production"
   4 "Low testosterone level"
   5 "Other"
   6 "None of the above"
   8 "Refused"
   9 "Don't know";

 label define DONBLOOD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define HIVTEST
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define NOHIVTST
   1 "You have never been offered an HIV test"
   2 "You are worried about what other people would think if you got tested for HIV"
   3 "It's unlikely you've been exposed to HIV"
   4 "You were afraid to find out if you were HIV positive (that you had HIV)"
   5 "You don't like needles"
  20 "Some other reason"
  21 "R reported spouse or partner tested negative"
  22 "Never had sexual intercourse"
  23 "No health insurance or coverage, or R couldn't afford an HIV test"
  24 "Part of blood donation"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define WHENHIV_M
  13 "Winter"
  14 "Spring"
  15 "Summer"
  16 "Fall"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define WHENHIV_Y
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMHIVTST
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define HIVTSTYR
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define HIVRESULT
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WHYNOGET
   1 "You thought the testing site would contact you"
   2 "You were afraid to find out if you were HIV positive (that you had HIV)"
   3 "You didn't want to know your HIV test results"
   4 "You didn't know where or how to get your test result"
  20 "Some other reason"
  98 "Refused"
  99 "Don't know";

 label define PLCHIV
   1 "Private doctor's office"
   2 "HMO facility"
   3 "Community health clinic, community clinic, public health clinic"
   4 "Family planning or Planned Parenthood clinic"
   5 "Employer or company clinic"
   6 "School or school-based clinic (including college or university)"
   7 "Hospital outpatient clinic"
   8 "Hospital emergency room"
   9 "Hospital regular room"
  10 "Urgent care center, urgi-care, or walk-in facility"
  11 "Your worksite"
  12 "Your home"
  13 "Military induction or military service site"
  14 "Sexually transmitted disease (STD) clinic"
  15 "Laboratory or blood bank"
  20 "Some other place not shown separately"
  21 "Prison or jail"
  22 "Mobile testing or community testing site"
  23 "Drug, alcohol or rehabilitation treatment center"
  98 "Refused"
  99 "Don't know";

 label define RHHIVT1
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RHHIVT21
   1 "I didn't want to get tested by a doctor or at an HIV testing site"
   2 "I didn't want other people to know I am getting tested"
   3 "I wanted to get tested together with someone, before we had sex"
   4 "I wanted to get tested by myself, before having sex"
   5 "I wanted to get tested by myself, after having sex"
   6 "A sex partner asked me to take a rapid home HIV test"
  20 "Other reason"
  98 "Refused"
  99 "Don't know";

 label define HIVTST
   1 "Part of a medical checkup or surgical procedure (a doctor or medical provider asked for the test)"
   2 "Required for health or life insurance coverage"
   3 "Required for marriage license or to get married"
   4 "Required for military service or job"
   5 "You wanted to find out if infected or not (you were the one who asked for the test)"
   6 "Someone else suggested you should be tested (followed by WHOSUGG question)"
   7 "Intentionally blank (a code used only for females, prenatal testing)"
   8 "You might have been exposed through sex or drug use"
   9 "You might have been exposed in some other way"
  20 "Some other reason - not shown separately"
  21 "Required for immigration or travel"
  22 "Required for incarceration"
  23 "Required for school"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define WHOSUGG
   1 "Doctor or other medical care provider"
   2 "Sexual partner"
   3 "Someone else"
   8 "Refused"
   9 "Don't know";

 label define TALKDOCT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define AIDSTALK01
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK02
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK03
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK04
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK05
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK06
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK07
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK08
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK09
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK10
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define AIDSTALK11
   1 "How HIV/AIDS is transmitted"
   2 "Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
   3 "The correct use of condoms"
   4 "Needle cleaning/using clean needles"
   5 "Dangers of needle sharing"
   6 "Abstinence from sex (not having sex)"
   7 "Reducing your number of sexual partners"
   8 "Condom use to prevent HIV or STD transmission"
   9 "'Safe sex' practices (abstinence, condom use, etc)"
  10 "Getting tested and knowing your HIV status"
  20 "Some other topic - not shown separately"
  98 "Refused"
  99 "Don't know";

 label define SAMEADD
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define CNTRY10
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define BRNOUT
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define YRSTRUS
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define RELRAISD
   1 "None"
   2 "Catholic"
   3 "Baptist/Southern Baptist"
   4 "Methodist, Lutheran, Presbyterian, Episcopal"
   5 "Fundamentalist Protestant"
   6 "Other Protestant denomination"
   7 "Protestant - No specific denomination"
   8 "Other religion"
   9 "Refused"
  10 "Don't know";

 label define ATTND14
   1 "More than once a week"
   2 "Once a week"
   3 "2-3 times a month"
   4 "Once a month (about 12 times a year)"
   5 "3-11 times a year"
   6 "Once or twice a year"
   7 "Never"
   8 "Refused"
   9 "Don't know";

 label define RELCURR
   1 "None"
   2 "Catholic"
   3 "Baptist/Southern Baptist"
   4 "Methodist, Lutheran, Presbyterian, Episcopal"
   5 "Fundamentalist Protestant"
   6 "Other Protestant denomination"
   7 "Protestant - No specific denomination"
   8 "Other religion"
   9 "Refused"
  10 "Don't know";

 label define RELTRAD
   1 "Evangelical Prot"
   2 "Mainline Prot"
   3 "Black Prot"
   4 "Catholic"
   5 "Other religion"
   6 "No religious affiilation"
   8 "Refused"
   9 "Don't know";

 label define FUNDAM1
   1 "A born again Christian"
   2 "A charismatic"
   3 "An evangelical"
   4 "A fundamentalist"
   5 "None of the above"
   8 "Refused"
   9 "Don't know";

 label define FUNDAM2
   1 "A born again Christian"
   2 "A charismatic"
   3 "An evangelical"
   4 "A fundamentalist"
   5 "None of the above"
   8 "Refused"
   9 "Don't know";

 label define FUNDAM3
   1 "A born again Christian"
   2 "A charismatic"
   3 "An evangelical"
   4 "A fundamentalist"
   5 "None of the above"
   8 "Refused"
   9 "Don't know";

 label define FUNDAM4
   1 "A born again Christian"
   2 "A charismatic"
   3 "An evangelical"
   4 "A fundamentalist"
   5 "None of the above"
   8 "Refused"
   9 "Don't know";

 label define RELDLIFE
   1 "Very important"
   2 "Somewhat important"
   3 "Not important"
   8 "Refused"
   9 "Don't know";

 label define ATTNDNOW
   1 "More than once a week"
   2 "Once a week"
   3 "2-3 times a month"
   4 "Once a month (about 12 times a year)"
   5 "3-11 times a year"
   6 "Once or twice a year"
   7 "Never"
   8 "Refused"
   9 "Don't know";

 label define MILSVC
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define WRK12MOS
   0 "No months"
   1 "1 month"
   2 "2 months"
   3 "3 months"
   4 "4 months"
   5 "5 months"
   6 "6 months"
   7 "7 months"
   8 "8 months"
   9 "9 months"
  10 "10 months"
  11 "11 months"
  12 "12 months"
  98 "Refused"
  99 "Don't know";

 label define FPT12MOS
   1 "Full-time"
   2 "Part-time"
   3 "Some of each"
   8 "Refused"
   9 "Don't know";

 label define DOLASTWK1
   1 "Working"
   2 "Working - Paternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "In school"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define DOLASTWK2
   1 "Working"
   2 "Working - Paternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "In school"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define DOLASTWK3
   1 "Working"
   2 "Working - Paternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "In school"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define DOLASTWK4
   1 "Working"
   2 "Working - Paternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "In school"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define DOLASTWK5
   1 "Working"
   2 "Working - Paternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "In school"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define DOLASTWK6
   1 "Working"
   2 "Working - Paternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "In school"
   6 "Other"
   8 "Refused"
   9 "Don't know";

 label define RWRKST
   1 "Yes"
   5 "No";

 label define WORKP12
   1 "Yes"
   5 "No";

 label define RPAYJOB
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define RNUMJOB
   0 "No jobs"
   1 "1 job"
   2 "2 jobs"
   3 "3 jobs"
   4 "4 jobs"
   5 "5 jobs"
   6 "6 jobs"
   8 "Refused"
   9 "Don't know";

 label define RFTPTX
   1 "Full-time"
   2 "Part-time"
   3 "Some of each"
   8 "Refused"
   9 "Don't know";

 label define REARNTY
   1 "Yes"
   5 "No";

 label define SPLSTWK1
   1 "Working"
   2 "Working - Maternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "Other"
   8 "Refused"
   9 "Don't know";

 label define SPLSTWK2
   1 "Working"
   2 "Working - Maternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "Other"
   8 "Refused"
   9 "Don't know";

 label define SPLSTWK3
   1 "Working"
   2 "Working - Maternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "Other"
   8 "Refused"
   9 "Don't know";

 label define SPLSTWK4
   1 "Working"
   2 "Working - Maternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "Other"
   8 "Refused"
   9 "Don't know";

 label define SPLSTWK5
   1 "Working"
   2 "Working - Maternity leave or temp leave"
   3 "Not working, looking for work"
   4 "Keeping house or taking care of family"
   5 "Other"
   8 "Refused"
   9 "Don't know";

 label define SPWRKST
   1 "Yes"
   5 "No";

 label define SPPAYJOB
   1 "Yes"
   5 "No"
   8 "Refused"
   9 "Don't know";

 label define SPNUMJOB
   1 "1 job"
   2 "2 jobs"
   3 "3 jobs"
   4 "4 jobs"
   5 "5 jobs"
   6 "6 jobs"
   8 "Refused"
   9 "Don't know";

 label define SPFTPTX
   1 "Full-time"
   2 "Part-time"
   3 "Some of each"
   8 "Refused"
   9 "Don't know";

 label define SPEARNTY
   1 "Yes"
   2 "No";

 label define SAMESEX
   1 "Strongly agree"
   2 "Agree"
   3 "Disagree"
   4 "Strongly disagree"
   5 "If R insists: Neither agree nor disagree"
   8 "Refused"
   9 "Don't know";

 label define CHSUPPOR
   1 "Strongly agree"
   2 "Agree"
   3 "Disagree"
   4 "Strongly disagree"
   5 "If R insists: Neither agree nor disagree"
   8 "Refused"
   9 "Don't know";

 label define REACTSLF
   1 "Very upset"
   2 "A little upset"
   3 "A little pleased"
   4 "Very pleased"
   5 "If R insists: He wouldn't care"
   8 "Refused"
   9 "Don't know";

 label define CHBOTHER
   1 "A great deal"
   2 "Some"
   3 "A little"
   4 "Not at all"
   8 "Refused"
   9 "Don't know";

 label define SEXNEEDS
   1 "Strongly agree"
   2 "Agree"
   3 "Disagree"
   4 "Strongly disagree"
   5 "If R insists: Neither agree nor disagree"
   8 "Refused"
   9 "Don't know";

 label define WHENSICK
   1 "Strongly agree"
   2 "Agree"
   3 "Disagree"
   4 "Strongly disagree"
   5 "If R insists: Neither agree nor disagree"
   8 "Refused"
   9 "Don't know";

 label define SHOWPAIN
   1 "Strongly agree"
   2 "Agree"
   3 "Disagree"
   4 "Strongly disagree"
   5 "If R insists: Neither agree nor disagree"
   8 "Refused"
   9 "Don't know";

 label define PMARCOHB
   1 "Yes"
   5 "No";

 label define COHCHANCE
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define MARRCHANCE
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define PMARCOH
   1 "Definitely yes"
   2 "Probably yes"
   3 "Probably no"
   4 "Definitely no"
   8 "Refused"
   9 "Don't know";

 label define ACASILANG
   1 "English"
   2 "Spanish"
   7 "Not ascertained";

 label define GENHEALT
   1 "Excellent"
   2 "Very good"
   3 "Good"
   4 "Fair"
   5 "Poor"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define INCHES
  64 "64 inches or less"
  65 "65 inches"
  66 "66 inches"
  67 "67 inches"
  68 "68 inches"
  69 "69 inches"
  70 "70 inches"
  71 "71 inches"
  72 "72 inches"
  73 "73 inches"
  74 "74 inches"
  75 "75 inches"
  76 "76 inches or more"
  96 "Could not be defined";

 label define RWEIGHT
 130 "130 POUNDS OR LESS"
 280 "280 POUNDS OR MORE"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define BMI
  95 "Could not be defined";

 label define DRWEIGH
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define TELLWGHT
   1 "Underweight"
   2 "Normal weight"
   3 "Overweight"
   4 "Obese"
   5 "Not told"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WGHTSCRN
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ENGSPEAK
   1 "Very well"
   2 "Well"
   3 "Not well"
   4 "Not at all"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NOBEDYR
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define STAYREL
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define JAILED
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define JAILED2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FRQJAIL
   1 "Only one time"
   2 "Or more than one time"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FRQJAIL2
   1 "One month or less"
   2 "More than one month but less than one year"
   3 "One year"
   4 "More than one year"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EVSUSPEN
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GRADSUSP
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define SMK100
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define AGESMK
   0 "NEVER SMOKED REGULARLY"
  11 "11 YEARS OR YOUNGER"
  12 "12 YEARS OLD"
  13 "13 YEARS OLD"
  14 "14 YEARS OLD"
  15 "15 YEARS OLD"
  16 "16 YEARS OLD"
  17 "17 YEARS OLD"
  18 "18 YEARS OLD"
  19 "19 YEARS OLD"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define SMOKE12
   1 "None"
   2 "About one cigarette a day or less"
   3 "Just a few cigarettes a day, between 2 to 4 cigarettes"
   4 "About half a pack a day, between 5 to 14 cigarettes"
   5 "About a pack a day, between 15 to 24 cigarettes"
   6 "More than a pack a day, 25 or more cigarettes"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define SMKSTOP
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define DRINK12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month"
   5 "About once a week"
   6 "About once a day"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define UNIT30D
   1 "Days per week"
   5 "Days per month"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define DRINK30D
   0 "0 DAYS"
   1 "1 DAY"
   2 "2 DAYS"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define DRINKDAY
   1 "1 DRINK"
   2 "2 DRINKS"
   3 "3 DRINKS"
   4 "4 DRINKS"
   5 "5 DRINKS"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BINGE30
   0 "NONE"
   1 "1 TIME"
   2 "2 TIMES"
   3 "3 TIMES"
   4 "4 TIMES"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define DRNKMOST
   1 "1 DRINK"
   2 "2 DRINKS"
   3 "3 DRINKS"
   4 "4 DRINKS"
   5 "5 DRINKS"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define BINGE12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month"
   5 "About once a week"
   6 "About once a day"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define POT12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month"
   5 "About once a week"
   6 "About once a day or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define COC12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CRACK12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CRYSTMTH12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define INJECT12
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MADEPREG
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PREGTOT2
   1 "1 TIME"
   2 "2 TIMES"
   3 "3 TIMES"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define PREGACASI
   0 "NEVER"
   1 "1 TIME"
   2 "2 TIMES"
   3 "3 TIMES"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define NUMABORT
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
   3 "3 PREGNANCIES"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define NUMLIVEB
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
   3 "3 PREGNANCIES"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define TOLDPREG
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WHATHAPP
   1 "Did it turn out that she was pregnant and you were the father,"
   2 "Or was she pregnant but you were not the father,"
   3 "Or did it turn out that she was not pregnant?"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FEMTOUCH
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define VAGSEX
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define AGEVAGR
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define CONDVAG
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define COND1BRK
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define COND1OFF
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WHYCONDL
   1 "To prevent pregnancy"
   2 "To prevent diseases like syphilis, gonorrhea or AIDS"
   3 "For both reasons"
   4 "For some other reason"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GETORALF
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CONDFELL
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GIVORALF
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ANYORAL
   1 "YES"
   5 "NO"
   7 "Not ascertained";

 label define TIMING
   1 "Before first vaginal intercourse"
   3 "After first vaginal intercourse"
   5 "Same occasion"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ANALSEX
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CONDANAL
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define OPPSEXANY
   1 "YES"
   5 "NO"
   7 "Not ascertained";

 label define OPPSEXGEN
   1 "YES"
   5 "NO"
   7 "Not ascertained";

 label define CONDSEXL
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WANTSEX1
   1 "I really didn't want it to happen at the time"
   2 "I had mixed feelings -- part of me wanted it to happen at the time and part of me didn't"
   3 "I really wanted it to happen at the time"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HOWOLD
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define EVRFORCD
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define AGEFORC1
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define GIVNDRG2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define SHEBIGOL
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ENDRELA2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WRDPRES2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define THRTPHY2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PHYSHRT2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HELDDWN2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PARTSLIF_1
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
  50 "50 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define PARTSLFV
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PARTSLIF_2
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
  50 "50 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define OPPLIFENUM
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
  50 "50 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define PARTS12_1
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
  20 "20 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define PARTS12V
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PARTS12_2
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
  20 "20 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define OPPYEARNUM
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
  20 "20 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define NEWYEAR
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define NEWLIFE
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define VAGNUM12
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define ORALNUM12
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define ANALNUM12
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define NONMONOG
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NNONMONOG1
   1 "1 partner"
   2 "2 or more partners"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NNONMONOG2
   1 "1 other partner besides you"
   2 "2 other partners besides you"
   3 "3 or more other partners besides you"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define NNONMONOG3
   1 "1 other partner besides you"
   2 "2 other partners besides you"
   3 "3 or more other partners besides you"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FEMSHT12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define JOHNFREQ
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PROSTFRQ
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HIVFEM12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GIVORALM
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GETORALM
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ORALCONDM
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ANALSEX2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ANALCONDM1
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ANALSEX3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ANALCONDM2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MALESEX
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define SAMESEXANY
   1 "YES"
   5 "NO"
   7 "Not ascertained";

 label define MALPRTAGE
   1 "Older"
   2 "Younger"
   3 "Same age"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MALPRTHRACE
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race"
   5 "NA/DK/RF";

 label define EVRFORC2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define AGEFORC2
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define GIVNDRG3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HEBIGOLD
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ENDRELA3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WRDPRES3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define THRTPHY3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PHYSHRT3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HELDDWN3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MALEPRTS_1
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define MALEPRTSV
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MALEPRTS_2
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define SAMLIFENUM
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  10 "10 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define MALPRT12_1
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define MALPRT12V
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MALPRT12_2
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define SAMYEARNUM
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 OR MORE PARTNERS"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define SAMORAL12
   0 "NONE"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define RECEPANAL12
   0 "NONE"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define INSERANAL12
   0 "NONE"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define SAMESEX1
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define MSAMEREL
   1 "Married to him"
   2 "Engaged to him"
   3 "Living together in a sexual relationship, but not engaged"
   4 "Going with him or going steady"
   5 "Going out with him once in a while"
   6 "Just friends"
   7 "Had just met him"
   8 "Something else"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define MSMNONMON
   0 "NONE"
 997 "Not ascertained"
 998 "Refused"
 999 "Don't know";

 label define MALSHT12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define JOHN2FRQ
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PROS2FRQ
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HIVMAL12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MSMWEB12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MSMSORT12
   1 "Yes, usually"
   3 "Yes, some of the time"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CNDLSMAL
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CONDALLS
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MFLASTP
   1 "Male"
   2 "Female"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WHYCOND
   1 "To prevent pregnancy"
   2 "To prevent diseases like syphilis, gonorrhea or AIDS"
   3 "For both reasons"
   4 "For some other reason"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ATTRACT
   1 "Only attracted to females"
   2 "Mostly attracted to females"
   3 "Equally attracted to females and males"
   4 "Mostly attracted to males"
   5 "Only attracted to males"
   6 "Not sure"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ORIENT_A
   1 "Heterosexual or straight"
   2 "Homosexual or gay"
   3 "Bisexual"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define ORIENT_B
   1 "Gay"
   2 "Straight, that is, not gay"
   3 "Bisexual"
   4 "Something else"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CONFCONC
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define TIMALON
   1 "Yes"
   5 "No"
   6 "Did not have a health care visit in the past 12 months"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RISKCHEK1
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RISKCHEK2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RISKCHEK3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RISKCHEK4
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define RECTDOUCH
   1 "Never"
   2 "Once or twice during the year"
   3 "Several times during the year"
   4 "About once a month"
   5 "About once a week"
   6 "About once a day or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define STDTST12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define STDSITE12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define STDTRT12
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GON
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define CHLAM
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HERPES
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define GENWARTS
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define SYPHILIS
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EVRINJECT
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EVRSHARE
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EARNTYPE
   1 "Week"
   2 "Month"
   3 "Year"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EARN
   1 "Under $96 (weekly)/Under $417 (monthly)/Under $5,000 (yearly)"
   2 "$96-$143 (weekly)/$417-624 (monthly)/$5,000-7,499 (yearly)"
   3 "$144-191 (weekly)/$625-832 (monthly)/$7,500-9,999 (yearly)"
   4 "$192-239 (weekly)/$833-1,041 (monthly)/$10,000-12,499 (yearly)"
   5 "$240-288 (weekly)/$1,042-1,249 (monthly)/$12,500-14,999 (yearly)"
   6 "$289-384 (weekly)/$1,250-1,666 (monthly)/$15,000-19,999 (yearly)"
   7 "$385-480 (weekly)/$1,667-2,082 (monthly)/$20,000-24,999 (yearly)"
   8 "$481-576 (weekly)/$2,083-2,499 (monthly)/$25,000-29,999 (yearly)"
   9 "$577-672 (weekly)/$2,500-2,916 (monthly)/$30,000-34,999 (yearly)"
  10 "$673-768 (weekly)/$2,917-3,332 (monthly)/$35,000-39,999 (yearly)"
  11 "$769-961 (weekly)/$3,333-4,166 (monthly)/$40,000-49,999 (yearly)"
  12 "$962-1,153 (weekly)/$4,167-4,999 (monthly)/$50,000-59,999 (yearly)"
  13 "$1,154-1,441 (weekly)/$5,000-6,249 (monthly)/$60,000-74,999 (yearly)"
  14 "$1,442-1,922 (weekly)/$6,250-8,332 (monthly)/$75,000-99,999 (yearly)"
  15 "$1,923 or more (weekly)/$8,333 or more (monthly)/$100,000 or more (yearly)"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define EARNDK1
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EARNDK2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EARNDK3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define EARNDK4
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define TOINCWMY
   1 "Week"
   2 "Month"
   3 "Year"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define TOTINC
   1 "Under $96 (weekly)/Under $417 (monthly)/Under $5,000 (yearly)"
   2 "$96-$143 (weekly)/$417-624 (monthly)/$5,000-7,499 (yearly)"
   3 "$144-191 (weekly)/$625-832 (monthly)/$7,500-9,999 (yearly)"
   4 "$192-239 (weekly)/$833-1,041 (monthly)/$10,000-12,499 (yearly)"
   5 "$240-288 (weekly)/$1,042-1,249 (monthly)/$12,500-14,999 (yearly)"
   6 "$289-384 (weekly)/$1,250-1,666 (monthly)/$15,000-19,999 (yearly)"
   7 "$385-480 (weekly)/$1,667-2,082 (monthly)/$20,000-24,999 (yearly)"
   8 "$481-576 (weekly)/$2,083-2,499 (monthly)/$25,000-29,999 (yearly)"
   9 "$577-672 (weekly)/$2,500-2,916 (monthly)/$30,000-34,999 (yearly)"
  10 "$673-768 (weekly)/$2,917-3,332 (monthly)/$35,000-39,999 (yearly)"
  11 "$769-961 (weekly)/$3,333-4,166 (monthly)/$40,000-49,999 (yearly)"
  12 "$962-1,153 (weekly)/$4,167-4,999 (monthly)/$50,000-59,999 (yearly)"
  13 "$1,154-1,441 (weekly)/$5,000-6,249 (monthly)/$60,000-74,999 (yearly)"
  14 "$1,442-1,922 (weekly)/$6,250-8,332 (monthly)/$75,000-99,999 (yearly)"
  15 "$1,923 or more (weekly)/$8,333 or more (monthly)/$100,000 or more (yearly)"
  97 "Not ascertained"
  98 "Refused"
  99 "Don't know";

 label define FMINCDK1
   1 "Less than $50,000"
   5 "$50,000 or more"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FMINCDK2
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FMINCDK3
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FMINCDK4
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FMINCDK5
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PUBASST
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define PUBASTYP1
   1 "Public assist prog, e.g. AFDC or ADC"
   2 "General/Emergency/Other assistance"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FOODSTMP
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define WIC
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HLPTRANS
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HLPCHLDC
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HLPJOB
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define FREEFOOD
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define HUNGRY
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define MED_COST
   1 "Yes"
   5 "No"
   7 "Not ascertained"
   8 "Refused"
   9 "Don't know";

 label define AGER
  15 "15 YEARS"
  16 "16 YEARS"
  17 "17 YEARS"
  18 "18 YEARS"
  19 "19 YEARS"
  20 "20 YEARS"
  21 "21 YEARS"
  22 "22 YEARS"
  23 "23 YEARS"
  24 "24 YEARS"
  25 "25 YEARS"
  26 "26 YEARS"
  27 "27 YEARS"
  28 "28 YEARS"
  29 "29 YEARS"
  30 "30 YEARS"
  31 "31 YEARS"
  32 "32 YEARS"
  33 "33 YEARS"
  34 "34 YEARS"
  35 "35 YEARS"
  36 "36 YEARS"
  37 "37 YEARS"
  38 "38 YEARS"
  39 "39 YEARS"
  40 "40 YEARS"
  41 "41 YEARS"
  42 "42 YEARS"
  43 "43 YEARS"
  44 "44 YEARS"
  45 "45 YEARS"
  46 "46 YEARS"
  47 "47 YEARS"
  48 "48 YEARS";

 label define FMARITAL
   1 "MARRIED TO A PERSON OF THE OPPOSITE SEX"
   2 "WIDOWED"
   3 "DIVORCED OR ANNULLED"
   4 "SEPARATED"
   5 "NEVER MARRIED";

 label define RMARITAL
   1 "CURRENTLY MARRIED TO A PERSON OF THE OPPOSITE SEX"
   2 "NOT MARRIED BUT LIVING WITH OPP SEX PARTNER"
   3 "WIDOWED"
   4 "DIVORCED OR ANNULLED"
   5 "SEPARATED FOR REASONS OF MARITAL DISCORD"
   6 "NEVER BEEN MARRIED";

 label define EDUCAT
   9 "9TH GRADE OR LESS"
  10 "10TH GRADE"
  11 "11TH GRADE"
  12 "12TH GRADE"
  13 "1 YEAR OF COLLEGE/GRAD SCHOOL"
  14 "2 YEARS OF COLLEGE/GRAD SCHOOL"
  15 "3 YEARS OF COLLEGE/GRAD SCHOOL"
  16 "4 YEARS OF COLLEGE/GRAD SCHOOL"
  17 "5 YEARS OF COLLEGE/GRAD SCHOOL"
  18 "6 YEARS OF COLLEGE/GRAD SCHOOL"
  19 "7+ YEARS OF COLLEGE/GRAD SCHOOL";

 label define HIEDUC
   5 "9TH GRADE OR LESS"
   6 "10TH GRADE"
   7 "11TH GRADE"
   8 "12TH GRADE, NO DIPLOMA (NOR GED)"
   9 "HIGH SCHOOL GRADUATE (DIPLOMA OR GED)"
  10 "SOME COLLEGE BUT NO DEGREE"
  11 "ASSOCIATE DEGREE IN COLLEGE/UNIVERSITY"
  12 "BACHELOR'S DEGREE"
  13 "MASTER'S DEGREE"
  14 "DOCTORATE DEGREE"
  15 "PROFESSIONAL DEGREE";

 label define HISPANIC
   1 "HISPANIC"
   2 "NON-HISPANIC";

 label define RACE
   1 "BLACK"
   2 "WHITE"
   3 "OTHER";

 label define HISPRACE
   1 "Hispanic"
   2 "Non-Hispanic White"
   3 "Non-Hispanic Black"
   4 "Non-Hispanic Other";

 label define HISPRACE2
   1 "Hispanic"
   2 "Non-Hispanic White, Single Race"
   3 "Non-Hispanic Black, Single Race"
   4 "Non-Hispanic Other or Multiple Race";

 label define NUMKDHH
   0 "NO CHILDREN"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
   4 "4 CHILDREN OR MORE";

 label define NUMFMHH
   0 "NO FAMILY MEMBERS"
   1 "1 FAMILY MEMBER"
   2 "2 FAMILY MEMBERS"
   3 "3 FAMILY MEMBERS"
   4 "4 FAMILY MEMBERS"
   5 "5 FAMILY MEMBERS"
   6 "6 FAMILY MEMBERS"
   7 "7 FAMILY MEMBERS OR MORE";

 label define HHFAMTYP
   1 "No spouse/partner and no child(ren) (of R) 18 or younger"
   2 "Spouse/partner, but no child(ren) (of R) 18 or younger"
   3 "Spouse and R's child(ren) 18 or younger"
   4 "Cohabiting partner and R's child(ren) 18 or younger"
   5 "No spouse/partner, but child(ren) of R, 18 or younger";

 label define HHPARTYP
   1 "Both biological or both adoptive parents"
   2 "Biological and step- or adoptive parent"
   3 "Single parent (biological, adoptive, or stepparent)"
   4 "Other";

 label define NCHILDHH
   0 "No children of respondent age 18 or younger in the household"
   1 "1 of respondent's children 18 or younger in the household"
   2 "2 of respondent's children 18 or younger in the household"
   3 "3 or more of respondent's children 18 or younger in the household";

 label define HHKIDTYP
   0 "No child(ren) 18 or younger in HH or only older child(ren)"
   1 "At least one biological child (of R's) under 18 in HH, no nonbiological child(ren)"
   2 "Any non-biological child (of R's) 18 or younger in HH";

 label define CSPBBHH
   0 "No joint biological children"
   1 "1 joint biological child"
   2 "2 joint biological children"
   3 "3 or more joint biological children";

 label define CSPSBHH
   0 "No such child"
   1 "1 or more such children";

 label define CSPOKDHH
   0 "No such child"
   1 "1 or more such children";

 label define INTCTFAM
   1 "TWO BIOLOGICAL OR ADOPTIVE PARENTS FROM BIRTH"
   2 "ANYTHING OTHER THAN 2 BIOLOGICAL OR ADOPTIVE PARENTS FROM BIRTH";

 label define PARAGE14
   1 "R LIVED WITH BOTH BIOLOGICAL OR BOTH ADOPTIVE PARENTS AT AGE 14"
   2 "R LIVED WITH BIOLOGICAL MOTHER AND STEPFATHER AT AGE 14"
   3 "R LIVED IN ANY OTHER PARENTAL SITUATION OR A NONPARENTAL SITUATION AT AGE 14";

 label define EDUCMOM
   1 "Less than high school"
   2 "High school graduate or GED"
   3 "Some college, including 2-year degrees"
   4 "Bachelor's degree or higher"
  95 "No mother/mother-figure identified";

 label define AGEMOMB1
   1 "LESS THAN 18 YEARS"
   2 "18-19 YEARS"
   3 "20-24 YEARS"
   4 "25-29 YEARS"
   5 "30 OR OLDER"
  95 "NO MOTHER OR MOTHER-FIGURE"
  96 "MOTHER-FIGURE HAD NO CHILDREN";

 label define FMARNO
   0 "NEVER BEEN MARRIED"
   1 "1 TIME"
   2 "2 TIMES"
   3 "3 TIMES";

 label define AGER_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define FMARITAL_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define RMARITAL_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define EDUCAT_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HIEDUC_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HISPANIC_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define RACE_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HISPRACE_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HISPRACE2_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NUMKDHH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NUMFMHH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HHFAMTYP_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HHPARTYP_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NCHILDHH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HHKIDTYP_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CSPBBHH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CSPSBHH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CSPOKDHH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define INTCTFAM_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARAGE14_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define EDUCMOM_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define AGEMOMB1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define FMARNO_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define HADSEX
   1 "YES, R EVER HAD INTERCOURSE"
   2 "NO, R NEVER HAD INTERCOURSE";

 label define SEXONCE
   1 "YES (R HAS HAD SEX ONLY ONCE)"
   2 "NO (R HAS HAD SEX MORE THAN ONCE)";

 label define VRY1STSX
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define FIRSTPFLAG
   1 "cmfstsex - CM of first sex ever, based on DL series"
   2 "cmlsxp - CM when R last had sex with most recent partner"
   3 "cmlsxp2 - CM when R last had sex with 2nd-to-last partner"
   4 "cmlsxp3 - CM when R last had sex with 3rd-to-last partner"
   5 "cmfsxp - CM when R first had sex with most recent partner"
   6 "cmfsxp2 - CM when R first had sex with 2nd-to-last partner"
   7 "cmfsxp3 - CM when R first had sex with 3rd-to-last partner"
   8 "cmfsxcwp - CM when R first had sex with CWP"
   9 "unable to determine: raw variable(s) missing";

 label define ELAPSED
   0 "0";

 label define SEXMAR
   1 "0-12 months"
   2 "13-24 months"
   3 "25-36 months"
   4 "More than 3 years"
   5 "First intercourse after first marriage";

 label define SEXUNION
   1 "0-12 months"
   2 "13-24 months"
   3 "25-36 months"
   4 "More than 3 years"
   5 "First intercourse after first union";

 label define FSEXRLTN
   1 "MARRIED TO HER"
   2 "ENGAGED TO HER, AND LIVING TOGETHER"
   3 "ENGAGED TO HER, BUT NOT LIVING TOGETHER"
   4 "LIVING TOGETHER IN A SEXUAL RELATIONSHIP, BUT NOT ENGAGED"
   5 "GOING OUT WITH HER OR GOING STEADY"
   6 "GOING OUT WITH HER ONCE IN A WHILE"
   7 "JUST FRIENDS"
   8 "HAD JUST MET HER"
   9 "SOMETHING ELSE";

 label define SEX1MTHD1
   1 "Condom"
   2 "Withdrawal"
   3 "Vasectomy"
   4 "Pill"
   5 "Female sterilization"
   6 "Injection -- Depo-Provera/Lunelle"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant -- Norplant/Implanon/Nexplanon"
   9 "Rhythm or safe period"
  10 "Contraceptive Patch"
  11 "Vaginal contraceptive ring"
  12 "IUD, coil, loop"
  13 "Something else"
  96 "No method used at first intercourse";

 label define SEX1MTHD2
   1 "Condom"
   2 "Withdrawal"
   3 "Vasectomy"
   4 "Pill"
   5 "Female sterilization"
   6 "Injection -- Depo-Provera/Lunelle"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant -- Norplant/Implanon/Nexplanon"
   9 "Rhythm or safe period"
  10 "Contraceptive Patch"
  11 "Vaginal contraceptive ring"
  12 "IUD, coil, loop"
  13 "Something else"
  96 "No method used at first intercourse";

 label define SEX1MTHD3
   1 "Condom"
   2 "Withdrawal"
   3 "Vasectomy"
   4 "Pill"
   5 "Female sterilization"
   6 "Injection -- Depo-Provera/Lunelle"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant -- Norplant/Implanon/Nexplanon"
   9 "Rhythm or safe period"
  10 "Contraceptive Patch"
  11 "Vaginal contraceptive ring"
  12 "IUD, coil, loop"
  13 "Something else"
  96 "No method used at first intercourse";

 label define SEX1MTHD4
   1 "Condom"
   2 "Withdrawal"
   3 "Vasectomy"
   4 "Pill"
   5 "Female sterilization"
   6 "Injection -- Depo-Provera/Lunelle"
   7 "Spermicidal foam/jelly/cream/film/suppository"
   8 "Hormonal implant -- Norplant/Implanon/Nexplanon"
   9 "Rhythm or safe period"
  10 "Contraceptive Patch"
  11 "Vaginal contraceptive ring"
  12 "IUD, coil, loop"
  13 "Something else"
  96 "No method used at first intercourse";

 label define LSEXDATE
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define SEX3MO
   1 "YES, HAD INTERCOURSE"
   2 "NO, DID NOT HAVE INTERCOURSE";

 label define SEX12MO
   1 "YES, HAD INTERCOURSE"
   2 "NO, DID NOT HAVE INTERCOURSE";

 label define LSEXPRAC
   1 "Hispanic"
   2 "Non-Hispanic White"
   3 "Non-Hispanic Black"
   4 "Non-Hispanic Other";

 label define LSEXRLTN
   1 "Married to her"
   3 "Living together in a sexual relationship"
   4 "Going out with her or going steady"
   5 "Going out with her once in a while"
   6 "Just friends"
   7 "Had just met her"
   8 "Something else"
   9 "Engaged to her: only asked of a subset of Rs";

 label define LSEXUSE1
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX";

 label define LSEXUSE2
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX";

 label define LSEXUSE3
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX";

 label define LSEXUSE4
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX";

 label define METH12M1
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 12 MONTHS";

 label define METH12M2
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 12 MONTHS";

 label define METH12M3
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 12 MONTHS";

 label define METH12M4
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 12 MONTHS";

 label define METH3M1
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 3 MONTHS";

 label define METH3M2
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 3 MONTHS";

 label define METH3M3
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 3 MONTHS";

 label define METH3M4
   1 "CONDOM"
   2 "WITHDRAWAL"
   3 "VASECTOMY"
   4 "PILL"
   5 "FEMALE STERILIZATION"
   6 "INJECTION -- DEPO-PROVERA/LUNELLE"
   7 "SPERMICIDAL FOAM/JELLY/CREAM/FILM/SUPPOSITORY"
   8 "HORMONAL IMPLANT -- NORPLANT/IMPLANON/NEXPLANON"
   9 "RHYTHM OR SAFE PERIOD"
  10 "CONTRACEPTIVE PATCH"
  11 "VAGINAL CONTRACEPTIVE RING"
  12 "IUD, COIL LOOP"
  13 "SOMETHING ELSE"
  95 "R USED NO METHOD; R DOES NOT KNOW IF PARTNER USED A METHOD"
  96 "NO METHOD USED AT LAST SEX IN THE PAST 3 MONTHS";

 label define NUMP3MOS
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS EXACTLY"
   4 "3, POSSIBLY MORE PARTNERS";

 label define LIFPRTNR
   0 "0 PARTNERS"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 PARTNERS"
   8 "8 PARTNERS"
   9 "9 PARTNERS"
  50 "50 OR MORE PARTNERS";

 label define PARTS1YR
   0 "NONE"
   1 "1 PARTNER"
   2 "2 PARTNERS"
   3 "3 PARTNERS"
   4 "4 PARTNERS"
   5 "5 PARTNERS"
   6 "6 PARTNERS"
   7 "7 OR MORE PARTNERS";

 label define PARTDUR1
 997 "Only had sex once with partner";

 label define PARTDUR2
 997 "Only had sex once with partner";

 label define PARTDUR3
 997 "Only had sex once with partner";

 label define COHEVER
   1 "Yes, ever cohabited (lived with a woman outside of marriage)"
   2 "No, never cohabited (lived with a woman outside of marriage)";

 label define EVMARCOH
   1 "Yes, ever married or cohabited"
   2 "No, never married or cohabited";

 label define PMARRNO
   0 "None"
   1 "One"
   2 "Two";

 label define NONMARR
   0 "None"
   1 "One"
   2 "Two";

 label define TIMESCOH
   0 "None"
   1 "One"
   2 "Two";

 label define MARDAT01
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDAT02
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDAT03
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDAT04
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MAREND01
   1 "DIVORCED OR ANNULLED"
   2 "SEPARATED"
   3 "WIDOWED";

 label define MAREND02
   1 "DIVORCED OR ANNULLED"
   2 "SEPARATED"
   3 "WIDOWED";

 label define MAREND03
   1 "DIVORCED OR ANNULLED"
   2 "SEPARATED"
   3 "WIDOWED";

 label define MAREND04
   1 "DIVORCED OR ANNULLED"
   2 "SEPARATED"
   3 "WIDOWED";

 label define MARDIS01
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDIS02
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDIS03
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MARDIS04
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define MAR1DISS
   1 "0-12 months"
   2 "13-24 months"
   3 "25-36 months"
   4 "37-48 months"
   5 "More than 4 years";

 label define PREMARW1
   1 "YES"
   2 "NO";

 label define COHAB1
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define COHSTAT
   1 "Never cohabited outside of marriage"
   2 "First cohabited before first marriage"
   3 "First cohabited after first marriage";

 label define COHOUT
   1 "Intact cohabitation"
   2 "Intact marriage"
   3 "Dissolved marriage"
   4 "Dissolved cohabitation";

 label define COH1DUR
   1 "0-12 months"
   2 "13-24 months"
   3 "25-36 months"
   4 "37-48 months"
   5 "More than 4 years";

 label define CSPBIOKD
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN";

 label define DATBABY1
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define B1PREMAR
   1 "Yes (1st biological child born before 1st marriage)"
   2 "No (1st biological child born in same month as or later than 1st marriage)";

 label define MARBABY1
   1 "Yes, married to child's mother"
   2 "No, not married to child's mother";

 label define CEBOW
   0 "None"
   1 "1 child"
   2 "2 children"
   3 "3 children"
   4 "4 children";

 label define CEBOWC
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN";

 label define CEBOWP
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN";

 label define EVRNOPAT
   1 "YES, 1 OR MORE CHILDREN OUT OF WEDLOCK, BUT NO ESTABLISHED PATERNITY"
   2 "NO, 1 OR MORE CHILDREN OUT OF WEDLOCK, BUT ESTABLISHED PATERNITY";

 label define NONLIVEB
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
  98 "REFUSED"
  99 "DON'T KNOW";

 label define COMPREG
   0 "NONE"
   1 "1 PREGNANCY"
   2 "2 PREGNANCIES"
   3 "3 PREGNANCIES"
   4 "4 PREGNANCIES";

 label define ABORTION
   0 "NONE"
   1 "1 PREGNANCY";

 label define LOSSNUM
   0 "NONE"
   1 "1 PREGNANCY";

 label define PARENT01
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT02
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT03
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT04
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT05
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT06
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT07
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT08
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT09
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define PARENT10
   1 "Current wife"
   2 "Current cohabiting partner"
   3 "Recent or last partner (up to 3 most recent in last 12 months), also an former wife or cohabiting partner"
   4 "Recent or last partner (up to 3 most recent in last 12 months), not a former wife or cohabiting partner"
   5 "Former wife (reported in Section E)"
   6 "First cohabiting partner (reported in Section E)"
   7 "Other sexual partner, not otherwise classified in codes 1-6";

 label define WANTB01
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB02
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB03
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB04
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB05
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB06
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB07
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB08
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB09
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define WANTB10
   1 "LATER, OVERDUE"
   2 "RIGHT TIME"
   3 "TOO SOON, MISTIMED"
   4 "DIDN'T CARE, INDIFFERENT"
   5 "UNWANTED"
   6 "DON'T KNOW, NOT SURE"
   7 "R DID NOT KNOW ABOUT THE PREGNANCY LEADING TO THE BIRTH";

 label define HADSEX_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEXONCE_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define VRY1STSX_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define VRY1STAG_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEXMAR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEXUNION_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define FSEXRLTN_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEX1MTHD1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEX1MTHD2_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEX1MTHD3_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEX1MTHD4_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXDATE_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEX3MO_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SEX12MO_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXRAGE_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXRLTN_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXUSE1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXUSE2_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXUSE3_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LSEXUSE4_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH12M1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH12M2_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH12M3_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH12M4_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH3M1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH3M2_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH3M3_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METH3M4_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NUMP3MOS_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LIFPRTNR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARTS1YR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARTDUR1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARTDUR2_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARTDUR3_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define COHEVER_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define EVMARCOH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PMARRNO_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NONMARR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define TIMESCOH_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDAT01_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDAT02_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDAT03_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDAT04_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MAREND01_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MAREND02_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MAREND03_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MAREND04_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDIS01_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDIS02_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDIS03_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARDIS04_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MAR1DISS_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PREMARW1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define COHAB1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define COHSTAT_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define COHOUT_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define COH1DUR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CSPBIOKD_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define DATBABY1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define AGEBABY1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define B1PREMAR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define MARBABY1_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CEBOW_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CEBOWC_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CEBOWP_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define EVRNOPAT_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NONLIVEB_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define COMPREG_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define ABORTION_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LOSSNUM_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT01_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT02_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT03_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT04_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT05_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT06_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT07_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT08_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT09_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PARENT10_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB01_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB02_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB03_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB04_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB05_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB06_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB07_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB08_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB09_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define WANTB10_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define DADTYPE
   1 "ONLY CORESIDENTIAL CHILDREN"
   2 "ONLY NON-CORESIDENTIAL CHILDREN"
   3 "BOTH CORESIDENTIAL AND NON-CORESIDENTIAL CHILDREN"
   4 "NO CHILDREN 18 OR YOUNGER, NO CHILDREN AT ALL, OR NEVER HAD SEXUAL INTERCOURSE";

 label define DADTYPU5
   1 "ONLY CORESIDENTIAL CHILDREN UNDER 5"
   2 "ONLY NON-CORESIDENTIAL CHILDREN UNDER 5"
   3 "BOTH CORESIDENTIAL AND NONCORESIDENTIAL CHILDREN UNDER 5"
   4 "NEITHER CORESIDENTIAL OR NONCORESIDENTIAL CHILDREN UNDER 5, NO CHILDREN, OR NEVER HAD SEXUAL INTERCOURSE";

 label define DADTYP518
   1 "ONLY CORESIDENTIAL CHILDREN 5 TO 18"
   2 "ONLY NON-CORESIDENTIAL CHILDREN 5 TO 18"
   3 "BOTH CORESIDENTIAL AND NONCORESIDENTIAL CHILDREN 5 TO 18"
   4 "NEITHER CORESIDENTIAL OR NONCORESIDENTIAL CHILDREN 5 TO 18, NO CHILDREN AT ALL, OR NEVER HAD SEXUAL INTERCOURSE";

 label define NUMCRU18
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN"
   4 "4 OR MORE CHILDREN";

 label define NUMNCU18
   0 "NONE"
   1 "1 CHILD"
   2 "2 CHILDREN"
   3 "3 CHILDREN";

 label define SUPP12MO
   1 "CONTRIBUTED CHILD SUPPORT ON A REGULAR BASIS IN LAST 12 MONTHS"
   2 "CONTRIBUTED CHILD SUPPORT ONCE IN A WHILE IN LAST 12 MONTHS"
   3 "DID NOT CONTRIBUTE CHILD SUPPORT IN LAST 12 MONTHS";

 label define DADTYPE_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define DADTYPU5_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define DADTYP518_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NUMCRU18_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define NUMNCU18_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define SUPP12MO_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define INTENT
   1 "R intends to have (more) children"
   2 "R does not intend to have (more) children"
   3 "R does not know his intent";

 label define ADDEXP
   0 "NO ADDITIONAL BIRTHS"
   5 ".5 ADDITIONAL BIRTHS"
  10 "1 ADDITIONAL BIRTH"
  15 "1.5 ADDITIONAL BIRTHS"
  20 "2 ADDITIONAL BIRTHS"
  25 "2.5 ADDITIONAL BIRTHS"
  30 "3 ADDITIONAL BIRTHS"
  35 "3.5 ADDITIONAL BIRTHS"
  40 "4 ADDITIONAL BIRTHS"
  45 "4.5 ADDITIONAL BIRTHS"
  50 "5 ADDITIONAL BIRTHS"
  55 "5.5 ADDITIONAL BIRTHS"
  60 "6 ADDITIONAL BIRTHS"
  65 "6.5 ADDITIONAL BIRTHS"
  70 "7 ADDITIONAL BIRTHS"
  78 "7.5 ADDITIONAL BIRTHS"
  80 "8 ADDITIONAL BIRTHS"
  85 "8.5 ADDITIONAL BIRTHS"
  90 "9 ADDITIONAL BIRTHS"
  95 "9.5 ADDITIONAL BIRTHS";

 label define INTENT_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define ADDEXP_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CURR_INS
   1 "Currently covered by private health insurance or Medi-Gap"
   2 "Currently covered by Medicaid, CHIP, or a state-sponsored health plan"
   3 "Currently covered by Medicare, military health care, or other government health care"
   4 "Currently covered only by a single-service plan, only by the Indian Health Service, or currently not covered by health insurance";

 label define INFEVER
   1 "YES"
   2 "NO";

 label define EVHIVTST
   0 "NO HIV TEST REPORTED"
   1 "YES, ONLY AS PART OF BLOOD DONATION"
   2 "YES, ONLY OUTSIDE OF BLOOD DONATION"
   3 "YES, IN BOTH CONTEXTS";

 label define CURR_INS_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define INFEVER_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define EVHIVTST_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define METRO
   1 "PRINCIPAL CITY OF MSA"
   2 "OTHER MSA"
   3 "NOT MSA";

 label define RELIGION
   1 "No religion"
   2 "Catholic"
   3 "Protestant"
   4 "Other religion";

 label define LABORFOR
   1 "Working full-time"
   2 "Working part-time"
   3 "Working, but on vacation, strike, or had temporary illness"
   4 "Working - paternity or family leave"
   5 "Not working but looking for work"
   6 "In school"
   7 "Keeping house"
   8 "Caring for family"
   9 "Other";

 label define METRO_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define RELIGION_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define LABORFOR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define POVERTY
 500 "500 percent of poverty level or greater";

 label define TOTINCR
   1 "Under $5000"
   2 "$5000-$7499"
   3 "$7500-$9999"
   4 "$10,000-$12,499"
   5 "$12,500-$14,999"
   6 "$15,000-$19,999"
   7 "$20,000-$24,999"
   8 "$25,000-$29,999"
   9 "$30,000-$34,999"
  10 "$35,000-$39,999"
  11 "$40,000-$49,999"
  12 "$50,000-$59,999"
  13 "$60,000-$74,999"
  14 "$75,000-$99,999"
  15 "$100,000 or more";

 label define PUBASSIS
   1 "Yes (received public assistance in [INTERVIEW YEAR -1])"
   2 "No (did not receive public assistance in [INTERVIEW YEAR -1])";

 label define POVERTY_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define TOTINCR_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define PUBASSIS_I
   0 "QUESTIONNAIRE DATA (NOT IMPUTED)"
   1 "MULTIPLE REGRESSION IMPUTATION"
   2 "LOGICAL IMPUTATION";

 label define CMINTVW
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMLSTYR
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label define CMFIVYR
9997 "Not ascertained"
9998 "Refused"
9999 "Don't know";

 label values RSCRNINF RSCRNINF ;
 label values RSCRAGE RSCRAGE ;
 label values RSCRHISP RSCRHISP ;
 label values RSCRRACE RSCRRACE ;
 label values AGE_A AGE_A ;
 label values AGE_R AGE_R ;
 label values AGESCRN AGESCRN ;
 label values HISP HISP ;
 label values HISPGRP HISPGRP ;
 label values PRIMLANG1 PRIMLANG1 ;
 label values PRIMLANG2 PRIMLANG2 ;
 label values PRIMLANG3 PRIMLANG3 ;
 label values ROSCNT ROSCNT ;
 label values MARSTAT MARSTAT ;
 label values FMARSTAT FMARSTAT ;
 label values FMARIT FMARIT ;
 label values EVRMARRY EVRMARRY ;
 label values WPLOCALE WPLOCALE ;
 label values WOMREL WOMREL ;
 label values GOSCHOL GOSCHOL ;
 label values VACA VACA ;
 label values HIGRADE HIGRADE ;
 label values COMPGRD COMPGRD ;
 label values DIPGED DIPGED ;
 label values EARNHS_Y EARNHS_Y ;
 label values HISCHGRD HISCHGRD ;
 label values LSTGRADE LSTGRADE ;
 label values MYSCHOL_Y MYSCHOL_Y ;
 label values HAVEDEG HAVEDEG ;
 label values DEGREES DEGREES ;
 label values EARNBA_Y EARNBA_Y ;
 label values EXPSCHL EXPSCHL ;
 label values EXPGRADE EXPGRADE ;
 label values WTHPARNW WTHPARNW ;
 label values ONOWN ONOWN ;
 label values ONOWN18 ONOWN18 ;
 label values INTACT INTACT ;
 label values PARMARR PARMARR ;
 label values INTACT18 INTACT18 ;
 label values LVSIT14F LVSIT14F ;
 label values LVSIT14M LVSIT14M ;
 label values WOMRASDU WOMRASDU ;
 label values MOMDEGRE MOMDEGRE ;
 label values MOMWORKD MOMWORKD ;
 label values MOMFSTCH MOMFSTCH ;
 label values MOM18 MOM18 ;
 label values MANRASDU MANRASDU ;
 label values R_FOSTER R_FOSTER ;
 label values EVRFSTER EVRFSTER ;
 label values MNYFSTER MNYFSTER ;
 label values DURFSTER DURFSTER ;
 label values TIMESMAR TIMESMAR ;
 label values EVCOHAB1 EVCOHAB1 ;
 label values NUMCOH1 NUMCOH1 ;
 label values EVCOHAB2 EVCOHAB2 ;
 label values NUMCOH2 NUMCOH2 ;
 label values EVRCOHAB EVRCOHAB ;
 label values NUMWIFE NUMWIFE ;
 label values NUMCOHAB NUMCOHAB ;
 label values EVERSEX EVERSEX ;
 label values RHADSEX RHADSEX ;
 label values SXMTONCE SXMTONCE ;
 label values YNOSEX YNOSEX ;
 label values TALKPAR1 TALKPAR1 ;
 label values TALKPAR2 TALKPAR2 ;
 label values TALKPAR3 TALKPAR3 ;
 label values TALKPAR4 TALKPAR4 ;
 label values TALKPAR5 TALKPAR5 ;
 label values TALKPAR6 TALKPAR6 ;
 label values TALKPAR7 TALKPAR7 ;
 label values SEDNO SEDNO ;
 label values SEDNOG SEDNOG ;
 label values SEDNOSX SEDNOSX ;
 label values SEDBC SEDBC ;
 label values SEDBCLC1 SEDBCLC1 ;
 label values SEDBCLC2 SEDBCLC2 ;
 label values SEDBCLC3 SEDBCLC3 ;
 label values SEDBCLC4 SEDBCLC4 ;
 label values SEDBCG SEDBCG ;
 label values SEDBCSX SEDBCSX ;
 label values SEDWHBC SEDWHBC ;
 label values SEDWHBCG SEDWHBCG ;
 label values SEDWBCSX SEDWBCSX ;
 label values SEDCOND SEDCOND ;
 label values SEDCONDG SEDCONDG ;
 label values SEDCONSX SEDCONSX ;
 label values SEDSTD SEDSTD ;
 label values SEDSTDG SEDSTDG ;
 label values SEDSTDSX SEDSTDSX ;
 label values SEDHIV SEDHIV ;
 label values SEDHIVG SEDHIVG ;
 label values SEDHIVSX SEDHIVSX ;
 label values SEDABST SEDABST ;
 label values SEDABLC1 SEDABLC1 ;
 label values SEDABLC2 SEDABLC2 ;
 label values SEDABLC3 SEDABLC3 ;
 label values SEDABLC4 SEDABLC4 ;
 label values SEDABSTG SEDABSTG ;
 label values SEDABSSX SEDABSSX ;
 label values EVEROPER EVEROPER ;
 label values TYPEOPER TYPEOPER ;
 label values STEROPER STEROPER ;
 label values VASEC_Y VASEC_Y ;
 label values PLCSTROP PLCSTROP ;
 label values RVRSVAS RVRSVAS ;
 label values VASREV_Y VASREV_Y ;
 label values RSURGSTR RSURGSTR ;
 label values FATHPOSS FATHPOSS ;
 label values FATHDIFF FATHDIFF ;
 label values RSTRSTAT RSTRSTAT ;
 label values LIFEPRT LIFEPRT ;
 label values LIFEPRTS LIFEPRTS ;
 label values SXMON12 SXMON12 ;
 label values MON12PRT MON12PRT ;
 label values MON12PRTS MON12PRTS ;
 label values SEXSTAT SEXSTAT ;
 label values P12MOCONO P12MOCONO ;
 label values P12MOCON P12MOCON ;
 label values SEXFREQ SEXFREQ ;
 label values CONFREQ CONFREQ ;
 label values P1RLTN1 P1RLTN1 ;
 label values P1CURRWIFE P1CURRWIFE ;
 label values P1CURRSEP P1CURRSEP ;
 label values P1RLTN2 P1RLTN2 ;
 label values P1COHABIT P1COHABIT ;
 label values P1SXLAST_M P1SXLAST_M ;
 label values P1SXLAST_Y P1SXLAST_Y ;
 label values CMLSXP1 CMLSXP1 ;
 label values P2RLTN1 P2RLTN1 ;
 label values P2CURRWIFE P2CURRWIFE ;
 label values P2CURRSEP P2CURRSEP ;
 label values P2RLTN2 P2RLTN2 ;
 label values P2COHABIT P2COHABIT ;
 label values P2SXLAST_M P2SXLAST_M ;
 label values P2SXLAST_Y P2SXLAST_Y ;
 label values CMLSXP2 CMLSXP2 ;
 label values P3RLTN1 P3RLTN1 ;
 label values P3CURRWIFE P3CURRWIFE ;
 label values P3CURRSEP P3CURRSEP ;
 label values P3RLTN2 P3RLTN2 ;
 label values P3COHABIT P3COHABIT ;
 label values P3SXLAST_M P3SXLAST_M ;
 label values P3SXLAST_Y P3SXLAST_Y ;
 label values CMLSXP3 CMLSXP3 ;
 label values P1RELATION P1RELATION ;
 label values P2RELATION P2RELATION ;
 label values P3RELATION P3RELATION ;
 label values FIRST FIRST ;
 label values MARRDATE_Y MARRDATE_Y ;
 label values HISAGEM HISAGEM ;
 label values LIVTOGWF LIVTOGWF ;
 label values STRTWFCP_Y STRTWFCP_Y ;
 label values HISAGEC HISAGEC ;
 label values CMSTRTWP CMSTRTWP ;
 label values ENGATHEN ENGATHEN ;
 label values WILLMARR WILLMARR ;
 label values CWPDOB_Y CWPDOB_Y ;
 label values CWPAGE CWPAGE ;
 label values CWPRACE CWPRACE ;
 label values CWPNRACE CWPNRACE ;
 label values CWPEDUCN CWPEDUCN ;
 label values CWPBORN CWPBORN ;
 label values CWPMARBF CWPMARBF ;
 label values CWPSX1WN_M CWPSX1WN_M ;
 label values CWPSX1WN_Y CWPSX1WN_Y ;
 label values CWPSX1AG CWPSX1AG ;
 label values CMFSXCWP CMFSXCWP ;
 label values AGEFSXCWP AGEFSXCWP ;
 label values CWPSX1RL CWPSX1RL ;
 label values CWPFUSE CWPFUSE ;
 label values CWPFMET01 CWPFMET01 ;
 label values CWPFMET02 CWPFMET02 ;
 label values CWPFMET03 CWPFMET03 ;
 label values CWPFMET04 CWPFMET04 ;
 label values CWPFMET05 CWPFMET05 ;
 label values CWPOPSTR CWPOPSTR ;
 label values CWPTYPOP1 CWPTYPOP1 ;
 label values CWPTYPOP2 CWPTYPOP2 ;
 label values CWPTOTST CWPTOTST ;
 label values CWPREVST CWPREVST ;
 label values PSURGSTR PSURGSTR ;
 label values CWPPOSS CWPPOSS ;
 label values CWPDIFF CWPDIFF ;
 label values PSTRSTAT PSTRSTAT ;
 label values CWPLSXWN_M CWPLSXWN_M ;
 label values CWPLSXWN_Y CWPLSXWN_Y ;
 label values CMLSXCWP CMLSXCWP ;
 label values CWPLUSE1 CWPLUSE1 ;
 label values CWPLMET11 CWPLMET11 ;
 label values CWPLMET12 CWPLMET12 ;
 label values CWPLMET13 CWPLMET13 ;
 label values CWPLUSE2 CWPLUSE2 ;
 label values DKCWPLUSE DKCWPLUSE ;
 label values CWPLMET201 CWPLMET201 ;
 label values CWPLMET202 CWPLMET202 ;
 label values DKCWPLMET DKCWPLMET ;
 label values CWPLSXUSE CWPLSXUSE ;
 label values CWPRECBC CWPRECBC ;
 label values CWPALLBC01 CWPALLBC01 ;
 label values CWPALLBC02 CWPALLBC02 ;
 label values CWPALLBC03 CWPALLBC03 ;
 label values CWPALLBC04 CWPALLBC04 ;
 label values CWPALLBC05 CWPALLBC05 ;
 label values CWPBCMST CWPBCMST ;
 label values CONDFREQ CONDFREQ ;
 label values CWPNOFRQ CWPNOFRQ ;
 label values CWPBIOKD CWPBIOKD ;
 label values CWPNUMKD CWPNUMKD ;
 label values PARTFATH PARTFATH ;
 label values CWPCHSEX CWPCHSEX ;
 label values CWPCHDOB_Y CWPCHDOB_Y ;
 label values CWPCHMAR CWPCHMAR ;
 label values CWPCHRES CWPCHRES ;
 label values CWPCHLRN CWPCHLRN ;
 label values CWPCHLIV1 CWPCHLIV1 ;
 label values CWPCHLIV2 CWPCHLIV2 ;
 label values CWPCHAGE CWPCHAGE ;
 label values CWPCHSIG CWPCHSIG ;
 label values CWPCHCRT CWPCHCRT ;
 label values CWPCHGEN CWPCHGEN ;
 label values CWPCHEVR CWPCHEVR ;
 label values CWPCHFAR CWPCHFAR ;
 label values CWPCHWNT CWPCHWNT ;
 label values CWPCHSON CWPCHSON ;
 label values CWPSOONN CWPSOONN ;
 label values CWPSOONMY CWPSOONMY ;
 label values CWPCHHPY CWPCHHPY ;
 label values CWPCHSEX2 CWPCHSEX2 ;
 label values CWPCHDOB_Y2 CWPCHDOB_Y2 ;
 label values MULTBIRT2 MULTBIRT2 ;
 label values CWPCHMAR2 CWPCHMAR2 ;
 label values CWPCHRES2 CWPCHRES2 ;
 label values CWPCHLRN2 CWPCHLRN2 ;
 label values CWPCHLIV10 CWPCHLIV10 ;
 label values CWPCHLIV11 CWPCHLIV11 ;
 label values CWPCHAGE2 CWPCHAGE2 ;
 label values CWPCHSIG2 CWPCHSIG2 ;
 label values CWPCHCRT2 CWPCHCRT2 ;
 label values CWPCHGEN2 CWPCHGEN2 ;
 label values CWPCHEVR2 CWPCHEVR2 ;
 label values CWPCHFAR2 CWPCHFAR2 ;
 label values CWPCHWNT2 CWPCHWNT2 ;
 label values CWPCHSON2 CWPCHSON2 ;
 label values CWPSOONN2 CWPSOONN2 ;
 label values CWPSOONMY2 CWPSOONMY2 ;
 label values CWPCHHPY2 CWPCHHPY2 ;
 label values CWPCHSEX3 CWPCHSEX3 ;
 label values CWPCHDOB_Y3 CWPCHDOB_Y3 ;
 label values MULTBIRT3 MULTBIRT3 ;
 label values CWPCHMAR3 CWPCHMAR3 ;
 label values CWPCHRES3 CWPCHRES3 ;
 label values CWPCHLRN3 CWPCHLRN3 ;
 label values CWPCHLIV19 CWPCHLIV19 ;
 label values CWPCHLIV20 CWPCHLIV20 ;
 label values CWPCHAGE3 CWPCHAGE3 ;
 label values CWPCHSIG3 CWPCHSIG3 ;
 label values CWPCHCRT3 CWPCHCRT3 ;
 label values CWPCHGEN3 CWPCHGEN3 ;
 label values CWPCHEVR3 CWPCHEVR3 ;
 label values CWPCHFAR3 CWPCHFAR3 ;
 label values CWPCHWNT3 CWPCHWNT3 ;
 label values CWPCHSON3 CWPCHSON3 ;
 label values CWPSOONN3 CWPSOONN3 ;
 label values CWPSOONMY3 CWPSOONMY3 ;
 label values CWPCHHPY3 CWPCHHPY3 ;
 label values CWPCHSEX4 CWPCHSEX4 ;
 label values CWPCHDOB_Y4 CWPCHDOB_Y4 ;
 label values MULTBIRT4 MULTBIRT4 ;
 label values CWPCHMAR4 CWPCHMAR4 ;
 label values CWPCHRES4 CWPCHRES4 ;
 label values CWPCHLRN4 CWPCHLRN4 ;
 label values CWPCHLIV28 CWPCHLIV28 ;
 label values CWPCHLIV29 CWPCHLIV29 ;
 label values CWPCHAGE4 CWPCHAGE4 ;
 label values CWPCHSIG4 CWPCHSIG4 ;
 label values CWPCHCRT4 CWPCHCRT4 ;
 label values CWPCHGEN4 CWPCHGEN4 ;
 label values CWPCHEVR4 CWPCHEVR4 ;
 label values CWPCHFAR4 CWPCHFAR4 ;
 label values CWPCHWNT4 CWPCHWNT4 ;
 label values CWPCHSON4 CWPCHSON4 ;
 label values CWPSOONN4 CWPSOONN4 ;
 label values CWPSOONMY4 CWPSOONMY4 ;
 label values CWPCHHPY4 CWPCHHPY4 ;
 label values CWPCHSEX5 CWPCHSEX5 ;
 label values CWPCHDOB_Y5 CWPCHDOB_Y5 ;
 label values MULTBIRT5 MULTBIRT5 ;
 label values CWPCHMAR5 CWPCHMAR5 ;
 label values CWPCHRES5 CWPCHRES5 ;
 label values CWPCHLRN5 CWPCHLRN5 ;
 label values CWPCHLIV37 CWPCHLIV37 ;
 label values CWPCHLIV38 CWPCHLIV38 ;
 label values CWPCHAGE5 CWPCHAGE5 ;
 label values CWPCHSIG5 CWPCHSIG5 ;
 label values CWPCHCRT5 CWPCHCRT5 ;
 label values CWPCHGEN5 CWPCHGEN5 ;
 label values CWPCHEVR5 CWPCHEVR5 ;
 label values CWPCHFAR5 CWPCHFAR5 ;
 label values CWPCHWNT5 CWPCHWNT5 ;
 label values CWPCHSON5 CWPCHSON5 ;
 label values CWPSOONN5 CWPSOONN5 ;
 label values CWPSOONMY5 CWPSOONMY5 ;
 label values CWPCHHPY5 CWPCHHPY5 ;
 label values CWPCHSEX6 CWPCHSEX6 ;
 label values CWPCHDOB_Y6 CWPCHDOB_Y6 ;
 label values MULTBIRT6 MULTBIRT6 ;
 label values CWPCHMAR6 CWPCHMAR6 ;
 label values CWPCHRES6 CWPCHRES6 ;
 label values CWPCHLRN6 CWPCHLRN6 ;
 label values CWPCHLIV46 CWPCHLIV46 ;
 label values CWPCHLIV47 CWPCHLIV47 ;
 label values CWPCHAGE6 CWPCHAGE6 ;
 label values CWPCHSIG6 CWPCHSIG6 ;
 label values CWPCHCRT6 CWPCHCRT6 ;
 label values CWPCHGEN6 CWPCHGEN6 ;
 label values CWPCHEVR6 CWPCHEVR6 ;
 label values CWPCHFAR6 CWPCHFAR6 ;
 label values CWPCHWNT6 CWPCHWNT6 ;
 label values CWPCHSON6 CWPCHSON6 ;
 label values CWPSOONN6 CWPSOONN6 ;
 label values CWPSOONMY6 CWPSOONMY6 ;
 label values CWPCHHPY6 CWPCHHPY6 ;
 label values CWPCHSEX7 CWPCHSEX7 ;
 label values CWPCHDOB_Y7 CWPCHDOB_Y7 ;
 label values MULTBIRT7 MULTBIRT7 ;
 label values CWPCHMAR7 CWPCHMAR7 ;
 label values CWPCHRES7 CWPCHRES7 ;
 label values CWPCHLRN7 CWPCHLRN7 ;
 label values CWPCHLIV55 CWPCHLIV55 ;
 label values CWPCHLIV56 CWPCHLIV56 ;
 label values CWPCHAGE7 CWPCHAGE7 ;
 label values CWPCHSIG7 CWPCHSIG7 ;
 label values CWPCHCRT7 CWPCHCRT7 ;
 label values CWPCHGEN7 CWPCHGEN7 ;
 label values CWPCHEVR7 CWPCHEVR7 ;
 label values CWPCHFAR7 CWPCHFAR7 ;
 label values CWPCHWNT7 CWPCHWNT7 ;
 label values CWPCHSON7 CWPCHSON7 ;
 label values CWPSOONN7 CWPSOONN7 ;
 label values CWPSOONMY7 CWPSOONMY7 ;
 label values CWPCHHPY7 CWPCHHPY7 ;
 label values CWPPRGNW CWPPRGNW ;
 label values CWPTRYPG CWPTRYPG ;
 label values CWPTRYLG CWPTRYLG ;
 label values CWPCPWNT CWPCPWNT ;
 label values CWPCPSON CWPCPSON ;
 label values CWPCPSNN CWPCPSNN ;
 label values CWPCPSNMY CWPCPSNMY ;
 label values CWPCPHPY CWPCPHPY ;
 label values C_OKAKIDS C_OKAKIDS ;
 label values CWPOTKID CWPOTKID ;
 label values CWPOKNUM CWPOKNUM ;
 label values CWPOKWTH CWPOKWTH ;
 label values CWPOKWTHN CWPOKWTHN ;
 label values CWPOKSEX CWPOKSEX ;
 label values CWPOKAD CWPOKAD ;
 label values CWPOKTRY CWPOKTRY ;
 label values CWPOKTHR CWPOKTHR ;
 label values CWPOKLIV1 CWPOKLIV1 ;
 label values CWPOKLIV2 CWPOKLIV2 ;
 label values CWPOKFAR CWPOKFAR ;
 label values CWPOKAGE CWPOKAGE ;
 label values CWPOKSEX2 CWPOKSEX2 ;
 label values CWPOKAD2 CWPOKAD2 ;
 label values CWPOKTRY2 CWPOKTRY2 ;
 label values CWPOKTHR2 CWPOKTHR2 ;
 label values CWPOKLIV8 CWPOKLIV8 ;
 label values CWPOKLIV9 CWPOKLIV9 ;
 label values CWPOKFAR2 CWPOKFAR2 ;
 label values CWPOKAGE2 CWPOKAGE2 ;
 label values CWPOKSEX3 CWPOKSEX3 ;
 label values CWPOKAD3 CWPOKAD3 ;
 label values CWPOKTRY3 CWPOKTRY3 ;
 label values CWPOKTHR3 CWPOKTHR3 ;
 label values CWPOKLIV15 CWPOKLIV15 ;
 label values CWPOKLIV16 CWPOKLIV16 ;
 label values CWPOKFAR3 CWPOKFAR3 ;
 label values CWPOKAGE3 CWPOKAGE3 ;
 label values CWPOKSEX4 CWPOKSEX4 ;
 label values CWPOKAD4 CWPOKAD4 ;
 label values CWPOKTRY4 CWPOKTRY4 ;
 label values CWPOKTHR4 CWPOKTHR4 ;
 label values CWPOKLIV22 CWPOKLIV22 ;
 label values CWPOKLIV23 CWPOKLIV23 ;
 label values CWPOKFAR4 CWPOKFAR4 ;
 label values CWPOKAGE4 CWPOKAGE4 ;
 label values CWPOKSEX5 CWPOKSEX5 ;
 label values CWPOKAD5 CWPOKAD5 ;
 label values CWPOKTRY5 CWPOKTRY5 ;
 label values CWPOKTHR5 CWPOKTHR5 ;
 label values CWPOKLIV29 CWPOKLIV29 ;
 label values CWPOKLIV30 CWPOKLIV30 ;
 label values CWPOKFAR5 CWPOKFAR5 ;
 label values CWPOKAGE5 CWPOKAGE5 ;
 label values C_NBAKIDS C_NBAKIDS ;
 label values CWPNBEVR CWPNBEVR ;
 label values CWPNBNUM CWPNBNUM ;
 label values CWPNBREL CWPNBREL ;
 label values CWPNBFOS CWPNBFOS ;
 label values CWPNBSEX CWPNBSEX ;
 label values CWPNBAD CWPNBAD ;
 label values CWPNBTRY CWPNBTRY ;
 label values CWPNBTHR CWPNBTHR ;
 label values CWPNBLIV1 CWPNBLIV1 ;
 label values CWPNBLIV2 CWPNBLIV2 ;
 label values CWPNBLIV3 CWPNBLIV3 ;
 label values CWPNBFAR CWPNBFAR ;
 label values CWPNBAGE CWPNBAGE ;
 label values CWPNBREL2 CWPNBREL2 ;
 label values CWPNBFOS2 CWPNBFOS2 ;
 label values CWPNBSEX2 CWPNBSEX2 ;
 label values CWPNBAD2 CWPNBAD2 ;
 label values CWPNBTRY2 CWPNBTRY2 ;
 label values CWPNBTHR2 CWPNBTHR2 ;
 label values CWPNBLIV8 CWPNBLIV8 ;
 label values CWPNBLIV9 CWPNBLIV9 ;
 label values CWPNBLIV10 CWPNBLIV10 ;
 label values CWPNBFAR2 CWPNBFAR2 ;
 label values CWPNBAGE2 CWPNBAGE2 ;
 label values CWPNBREL3 CWPNBREL3 ;
 label values CWPNBFOS3 CWPNBFOS3 ;
 label values CWPNBSEX3 CWPNBSEX3 ;
 label values CWPNBAD3 CWPNBAD3 ;
 label values CWPNBTRY3 CWPNBTRY3 ;
 label values CWPNBTHR3 CWPNBTHR3 ;
 label values CWPNBLIV15 CWPNBLIV15 ;
 label values CWPNBLIV16 CWPNBLIV16 ;
 label values CWPNBLIV17 CWPNBLIV17 ;
 label values CWPNBFAR3 CWPNBFAR3 ;
 label values CWPNBAGE3 CWPNBAGE3 ;
 label values CWPNBREL4 CWPNBREL4 ;
 label values CWPNBFOS4 CWPNBFOS4 ;
 label values CWPNBSEX4 CWPNBSEX4 ;
 label values CWPNBAD4 CWPNBAD4 ;
 label values CWPNBTRY4 CWPNBTRY4 ;
 label values CWPNBTHR4 CWPNBTHR4 ;
 label values CWPNBLIV22 CWPNBLIV22 ;
 label values CWPNBLIV23 CWPNBLIV23 ;
 label values CWPNBLIV24 CWPNBLIV24 ;
 label values CWPNBFAR4 CWPNBFAR4 ;
 label values CWPNBAGE4 CWPNBAGE4 ;
 label values CWPNBREL5 CWPNBREL5 ;
 label values CWPNBFOS5 CWPNBFOS5 ;
 label values CWPNBSEX5 CWPNBSEX5 ;
 label values CWPNBAD5 CWPNBAD5 ;
 label values CWPNBTRY5 CWPNBTRY5 ;
 label values CWPNBTHR5 CWPNBTHR5 ;
 label values CWPNBLIV29 CWPNBLIV29 ;
 label values CWPNBLIV30 CWPNBLIV30 ;
 label values CWPNBLIV31 CWPNBLIV31 ;
 label values CWPNBFAR5 CWPNBFAR5 ;
 label values CWPNBAGE5 CWPNBAGE5 ;
 label values CWPNBREL6 CWPNBREL6 ;
 label values CWPNBFOS6 CWPNBFOS6 ;
 label values CWPNBSEX6 CWPNBSEX6 ;
 label values CWPNBAD6 CWPNBAD6 ;
 label values CWPNBTRY6 CWPNBTRY6 ;
 label values CWPNBTHR6 CWPNBTHR6 ;
 label values CWPNBLIV36 CWPNBLIV36 ;
 label values CWPNBLIV37 CWPNBLIV37 ;
 label values CWPNBLIV38 CWPNBLIV38 ;
 label values CWPNBFAR6 CWPNBFAR6 ;
 label values CWPNBAGE6 CWPNBAGE6 ;
 label values CWPNBREL7 CWPNBREL7 ;
 label values CWPNBFOS7 CWPNBFOS7 ;
 label values CWPNBSEX7 CWPNBSEX7 ;
 label values CWPNBAD7 CWPNBAD7 ;
 label values CWPNBTRY7 CWPNBTRY7 ;
 label values CWPNBTHR7 CWPNBTHR7 ;
 label values CWPNBLIV43 CWPNBLIV43 ;
 label values CWPNBLIV44 CWPNBLIV44 ;
 label values CWPNBLIV45 CWPNBLIV45 ;
 label values CWPNBFAR7 CWPNBFAR7 ;
 label values CWPNBAGE7 CWPNBAGE7 ;
 label values CWPNBREL8 CWPNBREL8 ;
 label values CWPNBFOS8 CWPNBFOS8 ;
 label values CWPNBSEX8 CWPNBSEX8 ;
 label values CWPNBAD8 CWPNBAD8 ;
 label values CWPNBTRY8 CWPNBTRY8 ;
 label values CWPNBTHR8 CWPNBTHR8 ;
 label values CWPNBLIV50 CWPNBLIV50 ;
 label values CWPNBLIV51 CWPNBLIV51 ;
 label values CWPNBLIV52 CWPNBLIV52 ;
 label values CWPNBFAR8 CWPNBFAR8 ;
 label values CWPNBAGE8 CWPNBAGE8 ;
 label values CWPNBREL9 CWPNBREL9 ;
 label values CWPNBFOS9 CWPNBFOS9 ;
 label values CWPNBSEX9 CWPNBSEX9 ;
 label values CWPNBAD9 CWPNBAD9 ;
 label values CWPNBTRY9 CWPNBTRY9 ;
 label values CWPNBTHR9 CWPNBTHR9 ;
 label values CWPNBLIV57 CWPNBLIV57 ;
 label values CWPNBLIV58 CWPNBLIV58 ;
 label values CWPNBLIV59 CWPNBLIV59 ;
 label values CWPNBFAR9 CWPNBFAR9 ;
 label values CWPNBAGE9 CWPNBAGE9 ;
 label values CWPNBREL10 CWPNBREL10 ;
 label values CWPNBFOS10 CWPNBFOS10 ;
 label values CWPNBSEX10 CWPNBSEX10 ;
 label values CWPNBAD10 CWPNBAD10 ;
 label values CWPNBTRY10 CWPNBTRY10 ;
 label values CWPNBTHR10 CWPNBTHR10 ;
 label values CWPNBLIV64 CWPNBLIV64 ;
 label values CWPNBLIV65 CWPNBLIV65 ;
 label values CWPNBLIV66 CWPNBLIV66 ;
 label values CWPNBFAR10 CWPNBFAR10 ;
 label values CWPNBAGE10 CWPNBAGE10 ;
 label values MARDATEN_Y MARDATEN_Y ;
 label values AGEMARR AGEMARR ;
 label values LIVTOGN LIVTOGN ;
 label values STRTLIVE_Y STRTLIVE_Y ;
 label values AGELIV AGELIV ;
 label values CMUNIONP CMUNIONP ;
 label values ENGAGTHN ENGAGTHN ;
 label values MARREND MARREND ;
 label values WIFEDIED_Y WIFEDIED_Y ;
 label values DIVORFIN_Y DIVORFIN_Y ;
 label values ANNULLED_Y ANNULLED_Y ;
 label values STOPLIVE_Y STOPLIVE_Y ;
 label values MARDATEN_Y2 MARDATEN_Y2 ;
 label values AGEMARR2 AGEMARR2 ;
 label values LIVTOGN2 LIVTOGN2 ;
 label values STRTLIVE_Y2 STRTLIVE_Y2 ;
 label values AGELIV2 AGELIV2 ;
 label values ENGAGTHN2 ENGAGTHN2 ;
 label values MARREND2 MARREND2 ;
 label values WIFEDIED_Y2 WIFEDIED_Y2 ;
 label values DIVORFIN_Y2 DIVORFIN_Y2 ;
 label values ANNULLED_Y2 ANNULLED_Y2 ;
 label values STOPLIVE_Y2 STOPLIVE_Y2 ;
 label values MARDATEN_Y3 MARDATEN_Y3 ;
 label values AGEMARR3 AGEMARR3 ;
 label values LIVTOGN3 LIVTOGN3 ;
 label values STRTLIVE_Y3 STRTLIVE_Y3 ;
 label values AGELIV3 AGELIV3 ;
 label values ENGAGTHN3 ENGAGTHN3 ;
 label values MARREND3 MARREND3 ;
 label values WIFEDIED_Y3 WIFEDIED_Y3 ;
 label values DIVORFIN_Y3 DIVORFIN_Y3 ;
 label values ANNULLED_Y3 ANNULLED_Y3 ;
 label values STOPLIVE_Y3 STOPLIVE_Y3 ;
 label values CURRPRTS CURRPRTS ;
 label values PXCURR PXCURR ;
 label values PXCURRPRT PXCURRPRT ;
 label values PXMARRY PXMARRY ;
 label values PXCURR2 PXCURR2 ;
 label values PXCURRPRT2 PXCURRPRT2 ;
 label values PXMARRY2 PXMARRY2 ;
 label values PXCURR3 PXCURR3 ;
 label values PXCURRPRT3 PXCURRPRT3 ;
 label values PXMARRY3 PXMARRY3 ;
 label values PXLRUSE PXLRUSE ;
 label values PXLRMETH1 PXLRMETH1 ;
 label values PXLRMETH2 PXLRMETH2 ;
 label values PXLRMETH3 PXLRMETH3 ;
 label values PXLPUSE PXLPUSE ;
 label values DKPXLPUSE DKPXLPUSE ;
 label values PXLPMETH01 PXLPMETH01 ;
 label values PXLPMETH02 PXLPMETH02 ;
 label values PXLPMETH03 PXLPMETH03 ;
 label values DKPXLPMETH DKPXLPMETH ;
 label values LSXUSEP LSXUSEP ;
 label values MTONCEP MTONCEP ;
 label values PXLSXPRB PXLSXPRB ;
 label values PXMTONCE PXMTONCE ;
 label values PXFRLTN1 PXFRLTN1 ;
 label values P1YRACE1 P1YRACE1 ;
 label values P1YNRACE1 P1YNRACE1 ;
 label values PXLRUSE2 PXLRUSE2 ;
 label values PXLRMETH5 PXLRMETH5 ;
 label values PXLRMETH6 PXLRMETH6 ;
 label values PXLRMETH7 PXLRMETH7 ;
 label values PXLPUSE2 PXLPUSE2 ;
 label values DKPXLPUSE2 DKPXLPUSE2 ;
 label values PXLPMETH11 PXLPMETH11 ;
 label values PXLPMETH12 PXLPMETH12 ;
 label values PXLPMETH13 PXLPMETH13 ;
 label values DKPXLPMETH2 DKPXLPMETH2 ;
 label values LSXUSEP2 LSXUSEP2 ;
 label values MTONCEP2 MTONCEP2 ;
 label values PXLSXPRB2 PXLSXPRB2 ;
 label values PXMTONCE2 PXMTONCE2 ;
 label values PXFRLTN3 PXFRLTN3 ;
 label values P1YRACE2 P1YRACE2 ;
 label values P1YNRACE2 P1YNRACE2 ;
 label values PXLRUSE3 PXLRUSE3 ;
 label values PXLRMETH9 PXLRMETH9 ;
 label values PXLRMETH10 PXLRMETH10 ;
 label values PXLRMETH11 PXLRMETH11 ;
 label values PXLPUSE3 PXLPUSE3 ;
 label values DKPXLPUSE3 DKPXLPUSE3 ;
 label values PXLPMETH21 PXLPMETH21 ;
 label values PXLPMETH22 PXLPMETH22 ;
 label values PXLPMETH23 PXLPMETH23 ;
 label values DKPXLPMETH3 DKPXLPMETH3 ;
 label values LSXUSEP3 LSXUSEP3 ;
 label values MTONCEP3 MTONCEP3 ;
 label values PXLSXPRB3 PXLSXPRB3 ;
 label values PXMTONCE3 PXMTONCE3 ;
 label values PXFRLTN5 PXFRLTN5 ;
 label values P1YRACE3 P1YRACE3 ;
 label values P1YNRACE3 P1YNRACE3 ;
 label values PXDOB_Y PXDOB_Y ;
 label values PXEDUC PXEDUC ;
 label values PXMARBF PXMARBF ;
 label values PXANYCH PXANYCH ;
 label values PXANYCHN PXANYCHN ;
 label values PXABLECH PXABLECH ;
 label values PXDOB_Y2 PXDOB_Y2 ;
 label values PXEDUC2 PXEDUC2 ;
 label values PXMARBF2 PXMARBF2 ;
 label values PXANYCH2 PXANYCH2 ;
 label values PXANYCHN2 PXANYCHN2 ;
 label values PXABLECH2 PXABLECH2 ;
 label values PXDOB_Y3 PXDOB_Y3 ;
 label values PXEDUC3 PXEDUC3 ;
 label values PXMARBF3 PXMARBF3 ;
 label values PXANYCH3 PXANYCH3 ;
 label values PXANYCHN3 PXANYCHN3 ;
 label values PXABLECH3 PXABLECH3 ;
 label values PXSXFRST_M PXSXFRST_M ;
 label values PXSXFRST_Y PXSXFRST_Y ;
 label values CMFSXP CMFSXP ;
 label values AGEFSXP AGEFSXP ;
 label values PXAGFRST PXAGFRST ;
 label values PXFRLTN2 PXFRLTN2 ;
 label values PXFUSE PXFUSE ;
 label values PXFMETH01 PXFMETH01 ;
 label values PXFMETH02 PXFMETH02 ;
 label values PXFMETH03 PXFMETH03 ;
 label values PXFMETH04 PXFMETH04 ;
 label values PXSXFRST_M2 PXSXFRST_M2 ;
 label values PXSXFRST_Y2 PXSXFRST_Y2 ;
 label values CMFSXP2 CMFSXP2 ;
 label values AGEFSXP2 AGEFSXP2 ;
 label values PXAGFRST2 PXAGFRST2 ;
 label values PXFRLTN4 PXFRLTN4 ;
 label values PXFUSE2 PXFUSE2 ;
 label values PXFMETH14 PXFMETH14 ;
 label values PXFMETH15 PXFMETH15 ;
 label values PXFMETH16 PXFMETH16 ;
 label values PXFMETH17 PXFMETH17 ;
 label values PXSXFRST_M3 PXSXFRST_M3 ;
 label values PXSXFRST_Y3 PXSXFRST_Y3 ;
 label values CMFSXP3 CMFSXP3 ;
 label values AGEFSXP3 AGEFSXP3 ;
 label values PXAGFRST3 PXAGFRST3 ;
 label values PXFRLTN6 PXFRLTN6 ;
 label values PXFUSE3 PXFUSE3 ;
 label values PXFMETH27 PXFMETH27 ;
 label values PXFMETH28 PXFMETH28 ;
 label values PXFMETH29 PXFMETH29 ;
 label values PXFMETH30 PXFMETH30 ;
 label values PXANYUSE PXANYUSE ;
 label values PXMETHOD01 PXMETHOD01 ;
 label values PXMETHOD02 PXMETHOD02 ;
 label values PXMETHOD03 PXMETHOD03 ;
 label values PXMETHOD04 PXMETHOD04 ;
 label values PXMETHOD05 PXMETHOD05 ;
 label values PXMSTUSE PXMSTUSE ;
 label values PXCONFRQ PXCONFRQ ;
 label values PXNOFREQ PXNOFREQ ;
 label values PXANYUSE2 PXANYUSE2 ;
 label values PXMETHOD14 PXMETHOD14 ;
 label values PXMETHOD15 PXMETHOD15 ;
 label values PXMETHOD16 PXMETHOD16 ;
 label values PXMETHOD17 PXMETHOD17 ;
 label values PXMETHOD18 PXMETHOD18 ;
 label values PXMSTUSE2 PXMSTUSE2 ;
 label values PXCONFRQ2 PXCONFRQ2 ;
 label values PXNOFREQ2 PXNOFREQ2 ;
 label values PXANYUSE3 PXANYUSE3 ;
 label values PXMETHOD27 PXMETHOD27 ;
 label values PXMETHOD28 PXMETHOD28 ;
 label values PXMETHOD29 PXMETHOD29 ;
 label values PXMETHOD30 PXMETHOD30 ;
 label values PXMETHOD31 PXMETHOD31 ;
 label values PXMSTUSE3 PXMSTUSE3 ;
 label values PXCONFRQ3 PXCONFRQ3 ;
 label values PXNOFREQ3 PXNOFREQ3 ;
 label values PXCHILD PXCHILD ;
 label values PXCHILDN PXCHILDN ;
 label values PXCXSEX PXCXSEX ;
 label values PXCXBORN_Y PXCXBORN_Y ;
 label values MULTBIRT11 MULTBIRT11 ;
 label values PXCXMARB PXCXMARB ;
 label values PXCXRES PXCXRES ;
 label values PXCXKNOW PXCXKNOW ;
 label values PXCXLIV01 PXCXLIV01 ;
 label values PXCXLIV02 PXCXLIV02 ;
 label values PXCXLIV03 PXCXLIV03 ;
 label values PXCXAGE PXCXAGE ;
 label values PXCXSIG PXCXSIG ;
 label values PXCXCRT PXCXCRT ;
 label values PXCXGEN PXCXGEN ;
 label values PXCXEVER PXCXEVER ;
 label values PXCXFAR PXCXFAR ;
 label values PXWANT PXWANT ;
 label values PXSOON PXSOON ;
 label values PXSOONN PXSOONN ;
 label values PXSOONMY PXSOONMY ;
 label values PXHPYPG PXHPYPG ;
 label values PXCXSEX2 PXCXSEX2 ;
 label values PXCXBORN_Y2 PXCXBORN_Y2 ;
 label values MULTBIRT12 MULTBIRT12 ;
 label values PXCXMARB2 PXCXMARB2 ;
 label values PXCXRES2 PXCXRES2 ;
 label values PXCXKNOW2 PXCXKNOW2 ;
 label values PXCXLIV11 PXCXLIV11 ;
 label values PXCXLIV12 PXCXLIV12 ;
 label values PXCXLIV13 PXCXLIV13 ;
 label values PXCXAGE2 PXCXAGE2 ;
 label values PXCXSIG2 PXCXSIG2 ;
 label values PXCXCRT2 PXCXCRT2 ;
 label values PXCXGEN2 PXCXGEN2 ;
 label values PXCXEVER2 PXCXEVER2 ;
 label values PXCXFAR2 PXCXFAR2 ;
 label values PXWANT2 PXWANT2 ;
 label values PXSOON2 PXSOON2 ;
 label values PXSOONN2 PXSOONN2 ;
 label values PXSOONMY2 PXSOONMY2 ;
 label values PXHPYPG2 PXHPYPG2 ;
 label values PXCXSEX3 PXCXSEX3 ;
 label values PXCXBORN_Y3 PXCXBORN_Y3 ;
 label values MULTBIRT13 MULTBIRT13 ;
 label values PXCXMARB3 PXCXMARB3 ;
 label values PXCXRES3 PXCXRES3 ;
 label values PXCXKNOW3 PXCXKNOW3 ;
 label values PXCXLIV21 PXCXLIV21 ;
 label values PXCXLIV22 PXCXLIV22 ;
 label values PXCXLIV23 PXCXLIV23 ;
 label values PXCXAGE3 PXCXAGE3 ;
 label values PXCXSIG3 PXCXSIG3 ;
 label values PXCXCRT3 PXCXCRT3 ;
 label values PXCXGEN3 PXCXGEN3 ;
 label values PXCXEVER3 PXCXEVER3 ;
 label values PXCXFAR3 PXCXFAR3 ;
 label values PXWANT3 PXWANT3 ;
 label values PXSOON3 PXSOON3 ;
 label values PXSOONN3 PXSOONN3 ;
 label values PXSOONMY3 PXSOONMY3 ;
 label values PXHPYPG3 PXHPYPG3 ;
 label values PXCXSEX4 PXCXSEX4 ;
 label values PXCXBORN_Y4 PXCXBORN_Y4 ;
 label values MULTBIRT14 MULTBIRT14 ;
 label values PXCXMARB4 PXCXMARB4 ;
 label values PXCXRES4 PXCXRES4 ;
 label values PXCXKNOW4 PXCXKNOW4 ;
 label values PXCXLIV31 PXCXLIV31 ;
 label values PXCXLIV32 PXCXLIV32 ;
 label values PXCXLIV33 PXCXLIV33 ;
 label values PXCXAGE4 PXCXAGE4 ;
 label values PXCXSIG4 PXCXSIG4 ;
 label values PXCXCRT4 PXCXCRT4 ;
 label values PXCXGEN4 PXCXGEN4 ;
 label values PXCXEVER4 PXCXEVER4 ;
 label values PXCXFAR4 PXCXFAR4 ;
 label values PXWANT4 PXWANT4 ;
 label values PXSOON4 PXSOON4 ;
 label values PXSOONN4 PXSOONN4 ;
 label values PXSOONMY4 PXSOONMY4 ;
 label values PXHPYPG4 PXHPYPG4 ;
 label values PXCHILD2 PXCHILD2 ;
 label values PXCHILDN2 PXCHILDN2 ;
 label values PXCXSEX11 PXCXSEX11 ;
 label values PXCXBORN_Y11 PXCXBORN_Y11 ;
 label values MULTBIRT21 MULTBIRT21 ;
 label values PXCXMARB11 PXCXMARB11 ;
 label values PXCXRES11 PXCXRES11 ;
 label values PXCXKNOW11 PXCXKNOW11 ;
 label values PXCXLIV101 PXCXLIV101 ;
 label values PXCXLIV102 PXCXLIV102 ;
 label values PXCXAGE11 PXCXAGE11 ;
 label values PXCXSIG11 PXCXSIG11 ;
 label values PXCXCRT11 PXCXCRT11 ;
 label values PXCXGEN11 PXCXGEN11 ;
 label values PXCXEVER11 PXCXEVER11 ;
 label values PXCXFAR11 PXCXFAR11 ;
 label values PXWANT11 PXWANT11 ;
 label values PXSOON11 PXSOON11 ;
 label values PXSOONN11 PXSOONN11 ;
 label values PXSOONMY11 PXSOONMY11 ;
 label values PXHPYPG11 PXHPYPG11 ;
 label values PXCXSEX12 PXCXSEX12 ;
 label values PXCXBORN_Y12 PXCXBORN_Y12 ;
 label values MULTBIRT22 MULTBIRT22 ;
 label values PXCXMARB12 PXCXMARB12 ;
 label values PXCXRES12 PXCXRES12 ;
 label values PXCXKNOW12 PXCXKNOW12 ;
 label values PXCXLIV111 PXCXLIV111 ;
 label values PXCXLIV112 PXCXLIV112 ;
 label values PXCXAGE12 PXCXAGE12 ;
 label values PXCXSIG12 PXCXSIG12 ;
 label values PXCXCRT12 PXCXCRT12 ;
 label values PXCXGEN12 PXCXGEN12 ;
 label values PXCXEVER12 PXCXEVER12 ;
 label values PXCXFAR12 PXCXFAR12 ;
 label values PXWANT12 PXWANT12 ;
 label values PXSOON12 PXSOON12 ;
 label values PXSOONN12 PXSOONN12 ;
 label values PXSOONMY12 PXSOONMY12 ;
 label values PXHPYPG12 PXHPYPG12 ;
 label values PXCXSEX13 PXCXSEX13 ;
 label values PXCXBORN_Y13 PXCXBORN_Y13 ;
 label values MULTBIRT23 MULTBIRT23 ;
 label values PXCXMARB13 PXCXMARB13 ;
 label values PXCXRES13 PXCXRES13 ;
 label values PXCXKNOW13 PXCXKNOW13 ;
 label values PXCXLIV121 PXCXLIV121 ;
 label values PXCXLIV122 PXCXLIV122 ;
 label values PXCXAGE13 PXCXAGE13 ;
 label values PXCXSIG13 PXCXSIG13 ;
 label values PXCXCRT13 PXCXCRT13 ;
 label values PXCXGEN13 PXCXGEN13 ;
 label values PXCXEVER13 PXCXEVER13 ;
 label values PXCXFAR13 PXCXFAR13 ;
 label values PXWANT13 PXWANT13 ;
 label values PXSOON13 PXSOON13 ;
 label values PXSOONN13 PXSOONN13 ;
 label values PXSOONMY13 PXSOONMY13 ;
 label values PXHPYPG13 PXHPYPG13 ;
 label values PXCXSEX14 PXCXSEX14 ;
 label values PXCXBORN_Y14 PXCXBORN_Y14 ;
 label values MULTBIRT24 MULTBIRT24 ;
 label values PXCXMARB14 PXCXMARB14 ;
 label values PXCXRES14 PXCXRES14 ;
 label values PXCXKNOW14 PXCXKNOW14 ;
 label values PXCXLIV131 PXCXLIV131 ;
 label values PXCXLIV132 PXCXLIV132 ;
 label values PXCXAGE14 PXCXAGE14 ;
 label values PXCXSIG14 PXCXSIG14 ;
 label values PXCXCRT14 PXCXCRT14 ;
 label values PXCXGEN14 PXCXGEN14 ;
 label values PXCXEVER14 PXCXEVER14 ;
 label values PXCXFAR14 PXCXFAR14 ;
 label values PXWANT14 PXWANT14 ;
 label values PXSOON14 PXSOON14 ;
 label values PXSOONN14 PXSOONN14 ;
 label values PXSOONMY14 PXSOONMY14 ;
 label values PXHPYPG14 PXHPYPG14 ;
 label values PXCHILD3 PXCHILD3 ;
 label values PXCHILDN3 PXCHILDN3 ;
 label values PXCXSEX21 PXCXSEX21 ;
 label values PXCXBORN_Y21 PXCXBORN_Y21 ;
 label values MULTBIRT31 MULTBIRT31 ;
 label values PXCXMARB21 PXCXMARB21 ;
 label values PXCXRES21 PXCXRES21 ;
 label values PXCXKNOW21 PXCXKNOW21 ;
 label values PXCXLIV201 PXCXLIV201 ;
 label values PXCXLIV202 PXCXLIV202 ;
 label values PXCXAGE21 PXCXAGE21 ;
 label values PXCXSIG21 PXCXSIG21 ;
 label values PXCXCRT21 PXCXCRT21 ;
 label values PXCXGEN21 PXCXGEN21 ;
 label values PXCXEVER21 PXCXEVER21 ;
 label values PXCXFAR21 PXCXFAR21 ;
 label values PXWANT21 PXWANT21 ;
 label values PXSOON21 PXSOON21 ;
 label values PXSOONN21 PXSOONN21 ;
 label values PXSOONMY21 PXSOONMY21 ;
 label values PXHPYPG21 PXHPYPG21 ;
 label values PXCXSEX22 PXCXSEX22 ;
 label values PXCXBORN_Y22 PXCXBORN_Y22 ;
 label values MULTBIRT32 MULTBIRT32 ;
 label values PXCXMARB22 PXCXMARB22 ;
 label values PXCXRES22 PXCXRES22 ;
 label values PXCXKNOW22 PXCXKNOW22 ;
 label values PXCXLIV211 PXCXLIV211 ;
 label values PXCXLIV212 PXCXLIV212 ;
 label values PXCXAGE22 PXCXAGE22 ;
 label values PXCXSIG22 PXCXSIG22 ;
 label values PXCXCRT22 PXCXCRT22 ;
 label values PXCXGEN22 PXCXGEN22 ;
 label values PXCXEVER22 PXCXEVER22 ;
 label values PXCXFAR22 PXCXFAR22 ;
 label values PXWANT22 PXWANT22 ;
 label values PXSOON22 PXSOON22 ;
 label values PXSOONN22 PXSOONN22 ;
 label values PXSOONMY22 PXSOONMY22 ;
 label values PXHPYPG22 PXHPYPG22 ;
 label values PXCXSEX23 PXCXSEX23 ;
 label values PXCXBORN_Y23 PXCXBORN_Y23 ;
 label values MULTBIRT33 MULTBIRT33 ;
 label values PXCXMARB23 PXCXMARB23 ;
 label values PXCXRES23 PXCXRES23 ;
 label values PXCXKNOW23 PXCXKNOW23 ;
 label values PXCXLIV221 PXCXLIV221 ;
 label values PXCXLIV222 PXCXLIV222 ;
 label values PXCXAGE23 PXCXAGE23 ;
 label values PXCXSIG23 PXCXSIG23 ;
 label values PXCXCRT23 PXCXCRT23 ;
 label values PXCXGEN23 PXCXGEN23 ;
 label values PXCXEVER23 PXCXEVER23 ;
 label values PXCXFAR23 PXCXFAR23 ;
 label values PXWANT23 PXWANT23 ;
 label values PXSOON23 PXSOON23 ;
 label values PXSOONN23 PXSOONN23 ;
 label values PXSOONMY23 PXSOONMY23 ;
 label values PXHPYPG23 PXHPYPG23 ;
 label values PXCXSEX24 PXCXSEX24 ;
 label values PXCXBORN_Y24 PXCXBORN_Y24 ;
 label values MULTBIRT34 MULTBIRT34 ;
 label values PXCXMARB24 PXCXMARB24 ;
 label values PXCXRES24 PXCXRES24 ;
 label values PXCXKNOW24 PXCXKNOW24 ;
 label values PXCXLIV231 PXCXLIV231 ;
 label values PXCXLIV232 PXCXLIV232 ;
 label values PXCXAGE24 PXCXAGE24 ;
 label values PXCXSIG24 PXCXSIG24 ;
 label values PXCXCRT24 PXCXCRT24 ;
 label values PXCXGEN24 PXCXGEN24 ;
 label values PXCXEVER24 PXCXEVER24 ;
 label values PXCXFAR24 PXCXFAR24 ;
 label values PXWANT24 PXWANT24 ;
 label values PXSOON24 PXSOON24 ;
 label values PXSOONN24 PXSOONN24 ;
 label values PXSOONMY24 PXSOONMY24 ;
 label values PXHPYPG24 PXHPYPG24 ;
 label values PXCXSEX25 PXCXSEX25 ;
 label values PXCXBORN_Y25 PXCXBORN_Y25 ;
 label values MULTBIRT35 MULTBIRT35 ;
 label values PXCXMARB25 PXCXMARB25 ;
 label values PXCXRES25 PXCXRES25 ;
 label values PXCXKNOW25 PXCXKNOW25 ;
 label values PXCXLIV241 PXCXLIV241 ;
 label values PXCXLIV242 PXCXLIV242 ;
 label values PXCXAGE25 PXCXAGE25 ;
 label values PXCXSIG25 PXCXSIG25 ;
 label values PXCXCRT25 PXCXCRT25 ;
 label values PXCXGEN25 PXCXGEN25 ;
 label values PXCXEVER25 PXCXEVER25 ;
 label values PXCXFAR25 PXCXFAR25 ;
 label values PXWANT25 PXWANT25 ;
 label values PXSOON25 PXSOON25 ;
 label values PXSOONN25 PXSOONN25 ;
 label values PXSOONMY25 PXSOONMY25 ;
 label values PXHPYPG25 PXHPYPG25 ;
 label values PXCPREG PXCPREG ;
 label values PXTRYING PXTRYING ;
 label values PXTRYLONG PXTRYLONG ;
 label values PXRWANT PXRWANT ;
 label values PXRSOON PXRSOON ;
 label values PXRSOONN PXRSOONN ;
 label values PXRSOONMY PXRSOONMY ;
 label values PXCPFEEL PXCPFEEL ;
 label values PXCPREG2 PXCPREG2 ;
 label values PXTRYING2 PXTRYING2 ;
 label values PXTRYLONG2 PXTRYLONG2 ;
 label values PXRWANT2 PXRWANT2 ;
 label values PXRSOON2 PXRSOON2 ;
 label values PXRSOONN2 PXRSOONN2 ;
 label values PXRSOONMY2 PXRSOONMY2 ;
 label values PXCPFEEL2 PXCPFEEL2 ;
 label values PXCPREG3 PXCPREG3 ;
 label values PXTRYING3 PXTRYING3 ;
 label values PXTRYLONG3 PXTRYLONG3 ;
 label values PXRWANT3 PXRWANT3 ;
 label values PXRSOON3 PXRSOON3 ;
 label values PXRSOONN3 PXRSOONN3 ;
 label values PXRSOONMY3 PXRSOONMY3 ;
 label values PXCPFEEL3 PXCPFEEL3 ;
 label values CURRPREG CURRPREG ;
 label values D_OKAKIDS D_OKAKIDS ;
 label values PXOTKID PXOTKID ;
 label values PXOKNUM PXOKNUM ;
 label values PXOKWTH PXOKWTH ;
 label values PXOKWTHN PXOKWTHN ;
 label values PXOKSEX PXOKSEX ;
 label values PXOKAD PXOKAD ;
 label values PXOKLIV1 PXOKLIV1 ;
 label values PXOKFAR PXOKFAR ;
 label values PXOKAGE PXOKAGE ;
 label values PXOKSEX2 PXOKSEX2 ;
 label values PXOKAD2 PXOKAD2 ;
 label values PXOKLIV9 PXOKLIV9 ;
 label values PXOKFAR2 PXOKFAR2 ;
 label values PXOKAGE2 PXOKAGE2 ;
 label values PXOKSEX3 PXOKSEX3 ;
 label values PXOKAD3 PXOKAD3 ;
 label values PXOKLIV17 PXOKLIV17 ;
 label values PXOKFAR3 PXOKFAR3 ;
 label values PXOKAGE3 PXOKAGE3 ;
 label values PXOKSEX4 PXOKSEX4 ;
 label values PXOKAD4 PXOKAD4 ;
 label values PXOKLIV25 PXOKLIV25 ;
 label values PXOKFAR4 PXOKFAR4 ;
 label values PXOKAGE4 PXOKAGE4 ;
 label values D_OKAKIDS2 D_OKAKIDS2 ;
 label values PXOTKID2 PXOTKID2 ;
 label values PXOKNUM2 PXOKNUM2 ;
 label values PXOKWTH2 PXOKWTH2 ;
 label values PXOKWTHN2 PXOKWTHN2 ;
 label values PXOKSEX11 PXOKSEX11 ;
 label values PXOKAD11 PXOKAD11 ;
 label values PXOKLIV81 PXOKLIV81 ;
 label values PXOKFAR11 PXOKFAR11 ;
 label values PXOKAGE11 PXOKAGE11 ;
 label values PXOKSEX12 PXOKSEX12 ;
 label values PXOKAD12 PXOKAD12 ;
 label values PXOKLIV89 PXOKLIV89 ;
 label values PXOKFAR12 PXOKFAR12 ;
 label values PXOKAGE12 PXOKAGE12 ;
 label values PXOKSEX13 PXOKSEX13 ;
 label values PXOKAD13 PXOKAD13 ;
 label values PXOKLIV97 PXOKLIV97 ;
 label values PXOKFAR13 PXOKFAR13 ;
 label values PXOKAGE13 PXOKAGE13 ;
 label values PXOKSEX14 PXOKSEX14 ;
 label values PXOKAD14 PXOKAD14 ;
 label values PXOKLIV105 PXOKLIV105 ;
 label values PXOKFAR14 PXOKFAR14 ;
 label values PXOKAGE14 PXOKAGE14 ;
 label values PXOKSEX15 PXOKSEX15 ;
 label values PXOKAD15 PXOKAD15 ;
 label values PXOKLIV113 PXOKLIV113 ;
 label values PXOKFAR15 PXOKFAR15 ;
 label values PXOKAGE15 PXOKAGE15 ;
 label values D_OKAKIDS3 D_OKAKIDS3 ;
 label values PXOTKID3 PXOTKID3 ;
 label values PXOKNUM3 PXOKNUM3 ;
 label values PXOKWTH3 PXOKWTH3 ;
 label values PXOKWTHN3 PXOKWTHN3 ;
 label values PXOKSEX21 PXOKSEX21 ;
 label values PXOKAD21 PXOKAD21 ;
 label values PXOKAGE21 PXOKAGE21 ;
 label values PXOKSEX22 PXOKSEX22 ;
 label values PXOKAD22 PXOKAD22 ;
 label values PXOKAGE22 PXOKAGE22 ;
 label values PXOKSEX23 PXOKSEX23 ;
 label values PXOKAD23 PXOKAD23 ;
 label values PXOKAGE23 PXOKAGE23 ;
 label values PXOKSEX24 PXOKSEX24 ;
 label values PXOKAD24 PXOKAD24 ;
 label values PXOKAGE24 PXOKAGE24 ;
 label values PXOKSEX25 PXOKSEX25 ;
 label values PXOKAD25 PXOKAD25 ;
 label values PXOKAGE25 PXOKAGE25 ;
 label values D_NBAKIDS D_NBAKIDS ;
 label values PXNBEVR PXNBEVR ;
 label values PXNBNUM PXNBNUM ;
 label values PXNBREL PXNBREL ;
 label values PXNBFOS PXNBFOS ;
 label values PXNBSEX PXNBSEX ;
 label values PXNBAD PXNBAD ;
 label values PXNBLIV1 PXNBLIV1 ;
 label values PXNBLIV2 PXNBLIV2 ;
 label values PXNBFAR PXNBFAR ;
 label values PXNBAGE PXNBAGE ;
 label values PXNBREL2 PXNBREL2 ;
 label values PXNBFOS2 PXNBFOS2 ;
 label values PXNBSEX2 PXNBSEX2 ;
 label values PXNBAD2 PXNBAD2 ;
 label values PXNBLIV9 PXNBLIV9 ;
 label values PXNBLIV10 PXNBLIV10 ;
 label values PXNBFAR2 PXNBFAR2 ;
 label values PXNBAGE2 PXNBAGE2 ;
 label values PXNBREL3 PXNBREL3 ;
 label values PXNBFOS3 PXNBFOS3 ;
 label values PXNBSEX3 PXNBSEX3 ;
 label values PXNBAD3 PXNBAD3 ;
 label values PXNBLIV17 PXNBLIV17 ;
 label values PXNBLIV18 PXNBLIV18 ;
 label values PXNBFAR3 PXNBFAR3 ;
 label values PXNBAGE3 PXNBAGE3 ;
 label values D_NBAKIDS2 D_NBAKIDS2 ;
 label values PXNBEVR2 PXNBEVR2 ;
 label values PXNBNUM2 PXNBNUM2 ;
 label values PXNBREL11 PXNBREL11 ;
 label values PXNBFOS11 PXNBFOS11 ;
 label values PXNBSEX11 PXNBSEX11 ;
 label values PXNBAD11 PXNBAD11 ;
 label values PXNBAGE11 PXNBAGE11 ;
 label values PXNBREL12 PXNBREL12 ;
 label values PXNBFOS12 PXNBFOS12 ;
 label values PXNBSEX12 PXNBSEX12 ;
 label values PXNBAD12 PXNBAD12 ;
 label values PXNBAGE12 PXNBAGE12 ;
 label values PXNBREL13 PXNBREL13 ;
 label values PXNBFOS13 PXNBFOS13 ;
 label values PXNBSEX13 PXNBSEX13 ;
 label values PXNBAD13 PXNBAD13 ;
 label values PXNBAGE13 PXNBAGE13 ;
 label values PXNBREL14 PXNBREL14 ;
 label values PXNBFOS14 PXNBFOS14 ;
 label values PXNBSEX14 PXNBSEX14 ;
 label values PXNBAD14 PXNBAD14 ;
 label values PXNBAGE14 PXNBAGE14 ;
 label values PXNBREL15 PXNBREL15 ;
 label values PXNBFOS15 PXNBFOS15 ;
 label values PXNBSEX15 PXNBSEX15 ;
 label values PXNBAD15 PXNBAD15 ;
 label values PXNBAGE15 PXNBAGE15 ;
 label values PXNBREL16 PXNBREL16 ;
 label values PXNBFOS16 PXNBFOS16 ;
 label values PXNBSEX16 PXNBSEX16 ;
 label values PXNBAD16 PXNBAD16 ;
 label values PXNBAGE16 PXNBAGE16 ;
 label values PXNBREL17 PXNBREL17 ;
 label values PXNBFOS17 PXNBFOS17 ;
 label values PXNBSEX17 PXNBSEX17 ;
 label values PXNBAD17 PXNBAD17 ;
 label values PXNBAGE17 PXNBAGE17 ;
 label values PXNBREL18 PXNBREL18 ;
 label values PXNBFOS18 PXNBFOS18 ;
 label values PXNBSEX18 PXNBSEX18 ;
 label values PXNBAD18 PXNBAD18 ;
 label values PXNBAGE18 PXNBAGE18 ;
 label values D_NBAKIDS3 D_NBAKIDS3 ;
 label values PXNBEVR3 PXNBEVR3 ;
 label values FPFIRST_M FPFIRST_M ;
 label values FPFIRST_Y FPFIRST_Y ;
 label values CMFSTSEX CMFSTSEX ;
 label values FSTSEXAGE FSTSEXAGE ;
 label values FPAGE FPAGE ;
 label values FPAGE18 FPAGE18 ;
 label values FPAGE15 FPAGE15 ;
 label values FPAGE20 FPAGE20 ;
 label values RFSXAGEGP RFSXAGEGP ;
 label values FPRLTN FPRLTN ;
 label values FPUSE FPUSE ;
 label values FPMETH01 FPMETH01 ;
 label values FPMETH02 FPMETH02 ;
 label values FPMETH03 FPMETH03 ;
 label values FPMETH04 FPMETH04 ;
 label values FPPROBE FPPROBE ;
 label values NFORMWIFE NFORMWIFE ;
 label values NFORMCOHAB NFORMCOHAB ;
 label values FWVERIFY FWVERIFY ;
 label values FWVER FWVER ;
 label values FWVERIFY2 FWVERIFY2 ;
 label values FWVER2 FWVER2 ;
 label values FWVERIFY3 FWVERIFY3 ;
 label values FWVER3 FWVER3 ;
 label values FWVERIFY4 FWVERIFY4 ;
 label values FWVER4 FWVER4 ;
 label values FCVER FCVER ;
 label values FCVERIFY FCVERIFY ;
 label values EXRELATION EXRELATION ;
 label values FWMAREND_Y FWMAREND_Y ;
 label values AGEMARRN AGEMARRN ;
 label values LIVTOGN4 LIVTOGN4 ;
 label values STRTLIVE_Y4 STRTLIVE_Y4 ;
 label values AGELIV4 AGELIV4 ;
 label values CMUNIONW CMUNIONW ;
 label values ENGAGTHN4 ENGAGTHN4 ;
 label values MARREND4 MARREND4 ;
 label values WIFEDIED_Y4 WIFEDIED_Y4 ;
 label values DIVORFIN_Y4 DIVORFIN_Y4 ;
 label values ANNULLED_Y4 ANNULLED_Y4 ;
 label values STOPLIVE_Y4 STOPLIVE_Y4 ;
 label values EXRELATION2 EXRELATION2 ;
 label values FWMAREND_Y2 FWMAREND_Y2 ;
 label values AGEMARRN2 AGEMARRN2 ;
 label values LIVTOGN5 LIVTOGN5 ;
 label values STRTLIVE_Y5 STRTLIVE_Y5 ;
 label values AGELIV5 AGELIV5 ;
 label values ENGAGTHN5 ENGAGTHN5 ;
 label values MARREND5 MARREND5 ;
 label values WIFEDIED_Y5 WIFEDIED_Y5 ;
 label values DIVORFIN_Y5 DIVORFIN_Y5 ;
 label values ANNULLED_Y5 ANNULLED_Y5 ;
 label values STOPLIVE_Y5 STOPLIVE_Y5 ;
 label values EXRELATION3 EXRELATION3 ;
 label values FWMAREND_Y3 FWMAREND_Y3 ;
 label values AGEMARRN3 AGEMARRN3 ;
 label values LIVTOGN6 LIVTOGN6 ;
 label values STRTLIVE_Y6 STRTLIVE_Y6 ;
 label values AGELIV6 AGELIV6 ;
 label values ENGAGTHN6 ENGAGTHN6 ;
 label values MARREND6 MARREND6 ;
 label values WIFEDIED_Y6 WIFEDIED_Y6 ;
 label values DIVORFIN_Y6 DIVORFIN_Y6 ;
 label values ANNULLED_Y6 ANNULLED_Y6 ;
 label values STOPLIVE_Y6 STOPLIVE_Y6 ;
 label values EXRELATION4 EXRELATION4 ;
 label values FWMAREND_Y4 FWMAREND_Y4 ;
 label values AGEMARRN4 AGEMARRN4 ;
 label values LIVTOGN7 LIVTOGN7 ;
 label values STRTLIVE_Y7 STRTLIVE_Y7 ;
 label values AGELIV7 AGELIV7 ;
 label values ENGAGTHN7 ENGAGTHN7 ;
 label values MARREND7 MARREND7 ;
 label values WIFEDIED_Y7 WIFEDIED_Y7 ;
 label values DIVORFIN_Y7 DIVORFIN_Y7 ;
 label values ANNULLED_Y7 ANNULLED_Y7 ;
 label values STOPLIVE_Y7 STOPLIVE_Y7 ;
 label values EXRELATION11 EXRELATION11 ;
 label values STRTLIVE_Y14 STRTLIVE_Y14 ;
 label values CMCOHFC11 CMCOHFC11 ;
 label values AGELIV14 AGELIV14 ;
 label values ENGAGTHN14 ENGAGTHN14 ;
 label values STOPLIVE_Y14 STOPLIVE_Y14 ;
 label values FWPDOB_Y FWPDOB_Y ;
 label values FWPAGE FWPAGE ;
 label values WIF1RACE WIF1RACE ;
 label values WIF1NRACE WIF1NRACE ;
 label values FWPMARBF FWPMARBF ;
 label values FWPDOB_Y2 FWPDOB_Y2 ;
 label values FWPAGE2 FWPAGE2 ;
 label values FWPMARBF2 FWPMARBF2 ;
 label values FWPDOB_Y3 FWPDOB_Y3 ;
 label values FWPAGE3 FWPAGE3 ;
 label values FWPMARBF3 FWPMARBF3 ;
 label values FWPDOB_Y4 FWPDOB_Y4 ;
 label values FWPAGE4 FWPAGE4 ;
 label values FWPMARBF4 FWPMARBF4 ;
 label values FWPDOB_Y11 FWPDOB_Y11 ;
 label values FWPAGE11 FWPAGE11 ;
 label values COH1RACE COH1RACE ;
 label values COH1NRACE COH1NRACE ;
 label values FWPMARBF11 FWPMARBF11 ;
 label values FWPBIOKD FWPBIOKD ;
 label values FWPNUMKD FWPNUMKD ;
 label values FWPCHSEX FWPCHSEX ;
 label values FWPCHDOB_Y FWPCHDOB_Y ;
 label values FWCHMARB FWCHMARB ;
 label values FWPCHRES FWPCHRES ;
 label values FWPCHLRN FWPCHLRN ;
 label values FWPCHLIV01 FWPCHLIV01 ;
 label values FWPCHLIV02 FWPCHLIV02 ;
 label values FWPCHLIV03 FWPCHLIV03 ;
 label values FWPCHAGE FWPCHAGE ;
 label values FWPCHSIG FWPCHSIG ;
 label values FWPCHCRT FWPCHCRT ;
 label values FWPCHGEN FWPCHGEN ;
 label values FWPCHEVR FWPCHEVR ;
 label values FWPCHFAR FWPCHFAR ;
 label values FWPRWANT FWPRWANT ;
 label values FWPSOON FWPSOON ;
 label values FWPSOONN FWPSOONN ;
 label values FWPSOONMY FWPSOONMY ;
 label values FWPHPYPG FWPHPYPG ;
 label values FWPCHSEX2 FWPCHSEX2 ;
 label values FWPCHDOB_Y2 FWPCHDOB_Y2 ;
 label values MULTBIRT42 MULTBIRT42 ;
 label values FWCHMARB2 FWCHMARB2 ;
 label values FWPCHRES2 FWPCHRES2 ;
 label values FWPCHLRN2 FWPCHLRN2 ;
 label values FWPCHLIV11 FWPCHLIV11 ;
 label values FWPCHLIV12 FWPCHLIV12 ;
 label values FWPCHLIV13 FWPCHLIV13 ;
 label values FWPCHAGE2 FWPCHAGE2 ;
 label values FWPCHSIG2 FWPCHSIG2 ;
 label values FWPCHCRT2 FWPCHCRT2 ;
 label values FWPCHGEN2 FWPCHGEN2 ;
 label values FWPCHEVR2 FWPCHEVR2 ;
 label values FWPCHFAR2 FWPCHFAR2 ;
 label values FWPRWANT2 FWPRWANT2 ;
 label values FWPSOON2 FWPSOON2 ;
 label values FWPSOONN2 FWPSOONN2 ;
 label values FWPSOONMY2 FWPSOONMY2 ;
 label values FWPHPYPG2 FWPHPYPG2 ;
 label values FWPCHSEX3 FWPCHSEX3 ;
 label values FWPCHDOB_Y3 FWPCHDOB_Y3 ;
 label values MULTBIRT43 MULTBIRT43 ;
 label values FWCHMARB3 FWCHMARB3 ;
 label values FWPCHRES3 FWPCHRES3 ;
 label values FWPCHLRN3 FWPCHLRN3 ;
 label values FWPCHLIV21 FWPCHLIV21 ;
 label values FWPCHLIV22 FWPCHLIV22 ;
 label values FWPCHLIV23 FWPCHLIV23 ;
 label values FWPCHAGE3 FWPCHAGE3 ;
 label values FWPCHSIG3 FWPCHSIG3 ;
 label values FWPCHCRT3 FWPCHCRT3 ;
 label values FWPCHGEN3 FWPCHGEN3 ;
 label values FWPCHEVR3 FWPCHEVR3 ;
 label values FWPCHFAR3 FWPCHFAR3 ;
 label values FWPRWANT3 FWPRWANT3 ;
 label values FWPSOON3 FWPSOON3 ;
 label values FWPSOONN3 FWPSOONN3 ;
 label values FWPSOONMY3 FWPSOONMY3 ;
 label values FWPHPYPG3 FWPHPYPG3 ;
 label values FWPCHSEX4 FWPCHSEX4 ;
 label values FWPCHDOB_Y4 FWPCHDOB_Y4 ;
 label values MULTBIRT44 MULTBIRT44 ;
 label values FWCHMARB4 FWCHMARB4 ;
 label values FWPCHRES4 FWPCHRES4 ;
 label values FWPCHLRN4 FWPCHLRN4 ;
 label values FWPCHLIV31 FWPCHLIV31 ;
 label values FWPCHLIV32 FWPCHLIV32 ;
 label values FWPCHLIV33 FWPCHLIV33 ;
 label values FWPCHAGE4 FWPCHAGE4 ;
 label values FWPCHSIG4 FWPCHSIG4 ;
 label values FWPCHCRT4 FWPCHCRT4 ;
 label values FWPCHGEN4 FWPCHGEN4 ;
 label values FWPCHEVR4 FWPCHEVR4 ;
 label values FWPCHFAR4 FWPCHFAR4 ;
 label values FWPRWANT4 FWPRWANT4 ;
 label values FWPSOON4 FWPSOON4 ;
 label values FWPSOONN4 FWPSOONN4 ;
 label values FWPSOONMY4 FWPSOONMY4 ;
 label values FWPHPYPG4 FWPHPYPG4 ;
 label values FWPCHSEX5 FWPCHSEX5 ;
 label values FWPCHDOB_Y5 FWPCHDOB_Y5 ;
 label values MULTBIRT45 MULTBIRT45 ;
 label values FWCHMARB5 FWCHMARB5 ;
 label values FWPCHRES5 FWPCHRES5 ;
 label values FWPCHLRN5 FWPCHLRN5 ;
 label values FWPCHLIV41 FWPCHLIV41 ;
 label values FWPCHLIV42 FWPCHLIV42 ;
 label values FWPCHLIV43 FWPCHLIV43 ;
 label values FWPCHAGE5 FWPCHAGE5 ;
 label values FWPCHSIG5 FWPCHSIG5 ;
 label values FWPCHCRT5 FWPCHCRT5 ;
 label values FWPCHGEN5 FWPCHGEN5 ;
 label values FWPCHEVR5 FWPCHEVR5 ;
 label values FWPCHFAR5 FWPCHFAR5 ;
 label values FWPRWANT5 FWPRWANT5 ;
 label values FWPSOON5 FWPSOON5 ;
 label values FWPSOONN5 FWPSOONN5 ;
 label values FWPSOONMY5 FWPSOONMY5 ;
 label values FWPHPYPG5 FWPHPYPG5 ;
 label values FWPBIOKD2 FWPBIOKD2 ;
 label values FWPNUMKD2 FWPNUMKD2 ;
 label values FWPCHSEX11 FWPCHSEX11 ;
 label values FWPCHDOB_Y11 FWPCHDOB_Y11 ;
 label values FWCHMARB11 FWCHMARB11 ;
 label values FWPCHRES11 FWPCHRES11 ;
 label values FWPCHLRN11 FWPCHLRN11 ;
 label values FWPCHLIV101 FWPCHLIV101 ;
 label values FWPCHLIV102 FWPCHLIV102 ;
 label values FWPCHAGE11 FWPCHAGE11 ;
 label values FWPCHSIG11 FWPCHSIG11 ;
 label values FWPCHCRT11 FWPCHCRT11 ;
 label values FWPCHGEN11 FWPCHGEN11 ;
 label values FWPCHEVR11 FWPCHEVR11 ;
 label values FWPCHFAR11 FWPCHFAR11 ;
 label values FWPRWANT11 FWPRWANT11 ;
 label values FWPSOON11 FWPSOON11 ;
 label values FWPSOONN11 FWPSOONN11 ;
 label values FWPSOONMY11 FWPSOONMY11 ;
 label values FWPHPYPG11 FWPHPYPG11 ;
 label values FWPCHSEX12 FWPCHSEX12 ;
 label values FWPCHDOB_Y12 FWPCHDOB_Y12 ;
 label values MULTBIRT52 MULTBIRT52 ;
 label values FWCHMARB12 FWCHMARB12 ;
 label values FWPCHRES12 FWPCHRES12 ;
 label values FWPCHLRN12 FWPCHLRN12 ;
 label values FWPCHLIV111 FWPCHLIV111 ;
 label values FWPCHLIV112 FWPCHLIV112 ;
 label values FWPCHAGE12 FWPCHAGE12 ;
 label values FWPCHSIG12 FWPCHSIG12 ;
 label values FWPCHCRT12 FWPCHCRT12 ;
 label values FWPCHGEN12 FWPCHGEN12 ;
 label values FWPCHEVR12 FWPCHEVR12 ;
 label values FWPCHFAR12 FWPCHFAR12 ;
 label values FWPRWANT12 FWPRWANT12 ;
 label values FWPSOON12 FWPSOON12 ;
 label values FWPSOONN12 FWPSOONN12 ;
 label values FWPSOONMY12 FWPSOONMY12 ;
 label values FWPHPYPG12 FWPHPYPG12 ;
 label values FWPCHSEX13 FWPCHSEX13 ;
 label values FWPCHDOB_Y13 FWPCHDOB_Y13 ;
 label values MULTBIRT53 MULTBIRT53 ;
 label values FWCHMARB13 FWCHMARB13 ;
 label values FWPCHRES13 FWPCHRES13 ;
 label values FWPCHLRN13 FWPCHLRN13 ;
 label values FWPCHLIV121 FWPCHLIV121 ;
 label values FWPCHLIV122 FWPCHLIV122 ;
 label values FWPCHAGE13 FWPCHAGE13 ;
 label values FWPCHSIG13 FWPCHSIG13 ;
 label values FWPCHCRT13 FWPCHCRT13 ;
 label values FWPCHGEN13 FWPCHGEN13 ;
 label values FWPCHEVR13 FWPCHEVR13 ;
 label values FWPCHFAR13 FWPCHFAR13 ;
 label values FWPRWANT13 FWPRWANT13 ;
 label values FWPSOON13 FWPSOON13 ;
 label values FWPSOONN13 FWPSOONN13 ;
 label values FWPSOONMY13 FWPSOONMY13 ;
 label values FWPHPYPG13 FWPHPYPG13 ;
 label values FWPCHSEX14 FWPCHSEX14 ;
 label values FWPCHDOB_Y14 FWPCHDOB_Y14 ;
 label values MULTBIRT54 MULTBIRT54 ;
 label values FWCHMARB14 FWCHMARB14 ;
 label values FWPCHRES14 FWPCHRES14 ;
 label values FWPCHLRN14 FWPCHLRN14 ;
 label values FWPCHLIV131 FWPCHLIV131 ;
 label values FWPCHLIV132 FWPCHLIV132 ;
 label values FWPCHAGE14 FWPCHAGE14 ;
 label values FWPCHSIG14 FWPCHSIG14 ;
 label values FWPCHCRT14 FWPCHCRT14 ;
 label values FWPCHGEN14 FWPCHGEN14 ;
 label values FWPCHEVR14 FWPCHEVR14 ;
 label values FWPCHFAR14 FWPCHFAR14 ;
 label values FWPRWANT14 FWPRWANT14 ;
 label values FWPSOON14 FWPSOON14 ;
 label values FWPSOONN14 FWPSOONN14 ;
 label values FWPSOONMY14 FWPSOONMY14 ;
 label values FWPHPYPG14 FWPHPYPG14 ;
 label values FWPBIOKD3 FWPBIOKD3 ;
 label values FWPNUMKD3 FWPNUMKD3 ;
 label values FWPCHSEX21 FWPCHSEX21 ;
 label values FWPCHDOB_Y21 FWPCHDOB_Y21 ;
 label values FWCHMARB21 FWCHMARB21 ;
 label values FWPCHRES21 FWPCHRES21 ;
 label values FWPCHLRN21 FWPCHLRN21 ;
 label values FWPCHLIV201 FWPCHLIV201 ;
 label values FWPCHLIV202 FWPCHLIV202 ;
 label values FWPCHAGE21 FWPCHAGE21 ;
 label values FWPCHSIG21 FWPCHSIG21 ;
 label values FWPCHCRT21 FWPCHCRT21 ;
 label values FWPCHGEN21 FWPCHGEN21 ;
 label values FWPCHEVR21 FWPCHEVR21 ;
 label values FWPCHFAR21 FWPCHFAR21 ;
 label values FWPRWANT21 FWPRWANT21 ;
 label values FWPSOON21 FWPSOON21 ;
 label values FWPSOONN21 FWPSOONN21 ;
 label values FWPSOONMY21 FWPSOONMY21 ;
 label values FWPHPYPG21 FWPHPYPG21 ;
 label values FWPCHSEX22 FWPCHSEX22 ;
 label values FWPCHDOB_Y22 FWPCHDOB_Y22 ;
 label values MULTBIRT62 MULTBIRT62 ;
 label values FWCHMARB22 FWCHMARB22 ;
 label values FWPCHRES22 FWPCHRES22 ;
 label values FWPCHLRN22 FWPCHLRN22 ;
 label values FWPCHLIV211 FWPCHLIV211 ;
 label values FWPCHLIV212 FWPCHLIV212 ;
 label values FWPCHAGE22 FWPCHAGE22 ;
 label values FWPCHSIG22 FWPCHSIG22 ;
 label values FWPCHCRT22 FWPCHCRT22 ;
 label values FWPCHGEN22 FWPCHGEN22 ;
 label values FWPCHEVR22 FWPCHEVR22 ;
 label values FWPCHFAR22 FWPCHFAR22 ;
 label values FWPRWANT22 FWPRWANT22 ;
 label values FWPSOON22 FWPSOON22 ;
 label values FWPSOONN22 FWPSOONN22 ;
 label values FWPSOONMY22 FWPSOONMY22 ;
 label values FWPHPYPG22 FWPHPYPG22 ;
 label values FWPCHSEX23 FWPCHSEX23 ;
 label values FWPCHDOB_Y23 FWPCHDOB_Y23 ;
 label values MULTBIRT63 MULTBIRT63 ;
 label values FWCHMARB23 FWCHMARB23 ;
 label values FWPCHRES23 FWPCHRES23 ;
 label values FWPCHLRN23 FWPCHLRN23 ;
 label values FWPCHLIV221 FWPCHLIV221 ;
 label values FWPCHLIV222 FWPCHLIV222 ;
 label values FWPCHAGE23 FWPCHAGE23 ;
 label values FWPCHSIG23 FWPCHSIG23 ;
 label values FWPCHCRT23 FWPCHCRT23 ;
 label values FWPCHGEN23 FWPCHGEN23 ;
 label values FWPCHEVR23 FWPCHEVR23 ;
 label values FWPCHFAR23 FWPCHFAR23 ;
 label values FWPRWANT23 FWPRWANT23 ;
 label values FWPSOON23 FWPSOON23 ;
 label values FWPSOONN23 FWPSOONN23 ;
 label values FWPSOONMY23 FWPSOONMY23 ;
 label values FWPHPYPG23 FWPHPYPG23 ;
 label values FWPBIOKD4 FWPBIOKD4 ;
 label values FWPNUMKD4 FWPNUMKD4 ;
 label values FWPBIOKD11 FWPBIOKD11 ;
 label values FWPNUMKD11 FWPNUMKD11 ;
 label values FWPCHSEX101 FWPCHSEX101 ;
 label values FWPCHDOB_Y101 FWPCHDOB_Y101 ;
 label values FWPCHRES101 FWPCHRES101 ;
 label values FWPCHLRN101 FWPCHLRN101 ;
 label values FWPCHLIV1001 FWPCHLIV1001 ;
 label values FWPCHLIV1002 FWPCHLIV1002 ;
 label values FWPCHLIV1003 FWPCHLIV1003 ;
 label values FWPCHAGE101 FWPCHAGE101 ;
 label values FWPCHSIG101 FWPCHSIG101 ;
 label values FWPCHCRT101 FWPCHCRT101 ;
 label values FWPCHGEN101 FWPCHGEN101 ;
 label values FWPCHEVR101 FWPCHEVR101 ;
 label values FWPCHFAR101 FWPCHFAR101 ;
 label values FWPRWANT101 FWPRWANT101 ;
 label values FWPSOON101 FWPSOON101 ;
 label values FWPSOONN101 FWPSOONN101 ;
 label values FWPSOONMY101 FWPSOONMY101 ;
 label values FWPHPYPG101 FWPHPYPG101 ;
 label values FWPCHSEX102 FWPCHSEX102 ;
 label values FWPCHDOB_Y102 FWPCHDOB_Y102 ;
 label values MULTBIRT142 MULTBIRT142 ;
 label values FWPCHRES102 FWPCHRES102 ;
 label values FWPCHLRN102 FWPCHLRN102 ;
 label values FWPCHLIV1011 FWPCHLIV1011 ;
 label values FWPCHLIV1012 FWPCHLIV1012 ;
 label values FWPCHLIV1013 FWPCHLIV1013 ;
 label values FWPCHAGE102 FWPCHAGE102 ;
 label values FWPCHSIG102 FWPCHSIG102 ;
 label values FWPCHCRT102 FWPCHCRT102 ;
 label values FWPCHGEN102 FWPCHGEN102 ;
 label values FWPCHEVR102 FWPCHEVR102 ;
 label values FWPCHFAR102 FWPCHFAR102 ;
 label values FWPRWANT102 FWPRWANT102 ;
 label values FWPSOON102 FWPSOON102 ;
 label values FWPSOONN102 FWPSOONN102 ;
 label values FWPSOONMY102 FWPSOONMY102 ;
 label values FWPHPYPG102 FWPHPYPG102 ;
 label values FWPCHSEX103 FWPCHSEX103 ;
 label values FWPCHDOB_Y103 FWPCHDOB_Y103 ;
 label values MULTBIRT143 MULTBIRT143 ;
 label values FWPCHRES103 FWPCHRES103 ;
 label values FWPCHLRN103 FWPCHLRN103 ;
 label values FWPCHLIV1021 FWPCHLIV1021 ;
 label values FWPCHLIV1022 FWPCHLIV1022 ;
 label values FWPCHLIV1023 FWPCHLIV1023 ;
 label values FWPCHAGE103 FWPCHAGE103 ;
 label values FWPCHSIG103 FWPCHSIG103 ;
 label values FWPCHCRT103 FWPCHCRT103 ;
 label values FWPCHGEN103 FWPCHGEN103 ;
 label values FWPCHEVR103 FWPCHEVR103 ;
 label values FWPCHFAR103 FWPCHFAR103 ;
 label values FWPRWANT103 FWPRWANT103 ;
 label values FWPSOON103 FWPSOON103 ;
 label values FWPSOONN103 FWPSOONN103 ;
 label values FWPSOONMY103 FWPSOONMY103 ;
 label values FWPHPYPG103 FWPHPYPG103 ;
 label values FWPCHSEX104 FWPCHSEX104 ;
 label values FWPCHDOB_Y104 FWPCHDOB_Y104 ;
 label values MULTBIRT144 MULTBIRT144 ;
 label values FWPCHRES104 FWPCHRES104 ;
 label values FWPCHLRN104 FWPCHLRN104 ;
 label values FWPCHLIV1031 FWPCHLIV1031 ;
 label values FWPCHLIV1032 FWPCHLIV1032 ;
 label values FWPCHLIV1033 FWPCHLIV1033 ;
 label values FWPCHAGE104 FWPCHAGE104 ;
 label values FWPCHSIG104 FWPCHSIG104 ;
 label values FWPCHCRT104 FWPCHCRT104 ;
 label values FWPCHGEN104 FWPCHGEN104 ;
 label values FWPCHEVR104 FWPCHEVR104 ;
 label values FWPCHFAR104 FWPCHFAR104 ;
 label values FWPRWANT104 FWPRWANT104 ;
 label values FWPSOON104 FWPSOON104 ;
 label values FWPSOONN104 FWPSOONN104 ;
 label values FWPSOONMY104 FWPSOONMY104 ;
 label values FWPHPYPG104 FWPHPYPG104 ;
 label values E_OKAKIDS E_OKAKIDS ;
 label values FWPOTKID FWPOTKID ;
 label values FWPOKNUM FWPOKNUM ;
 label values FWPOKWTH FWPOKWTH ;
 label values FWPOKWTHN FWPOKWTHN ;
 label values FWPOKSEX FWPOKSEX ;
 label values FWPOKAD FWPOKAD ;
 label values FWPOKLIV1 FWPOKLIV1 ;
 label values FWPOKLIV2 FWPOKLIV2 ;
 label values FWPOKFAR FWPOKFAR ;
 label values FWPOKAGE FWPOKAGE ;
 label values FWPOKSEX2 FWPOKSEX2 ;
 label values FWPOKAD2 FWPOKAD2 ;
 label values FWPOKLIV9 FWPOKLIV9 ;
 label values FWPOKLIV10 FWPOKLIV10 ;
 label values FWPOKFAR2 FWPOKFAR2 ;
 label values FWPOKAGE2 FWPOKAGE2 ;
 label values FWPOKSEX3 FWPOKSEX3 ;
 label values FWPOKAD3 FWPOKAD3 ;
 label values FWPOKLIV17 FWPOKLIV17 ;
 label values FWPOKLIV18 FWPOKLIV18 ;
 label values FWPOKFAR3 FWPOKFAR3 ;
 label values FWPOKAGE3 FWPOKAGE3 ;
 label values FWPOKSEX4 FWPOKSEX4 ;
 label values FWPOKAD4 FWPOKAD4 ;
 label values FWPOKLIV25 FWPOKLIV25 ;
 label values FWPOKLIV26 FWPOKLIV26 ;
 label values FWPOKFAR4 FWPOKFAR4 ;
 label values FWPOKAGE4 FWPOKAGE4 ;
 label values FWPOKSEX5 FWPOKSEX5 ;
 label values FWPOKAD5 FWPOKAD5 ;
 label values FWPOKLIV33 FWPOKLIV33 ;
 label values FWPOKLIV34 FWPOKLIV34 ;
 label values FWPOKFAR5 FWPOKFAR5 ;
 label values FWPOKAGE5 FWPOKAGE5 ;
 label values E_OKAKIDS2 E_OKAKIDS2 ;
 label values FWPOTKID2 FWPOTKID2 ;
 label values FWPOKNUM2 FWPOKNUM2 ;
 label values FWPOKWTH2 FWPOKWTH2 ;
 label values FWPOKWTHN2 FWPOKWTHN2 ;
 label values FWPOKSEX11 FWPOKSEX11 ;
 label values FWPOKAD11 FWPOKAD11 ;
 label values FWPOKLIV81 FWPOKLIV81 ;
 label values FWPOKFAR11 FWPOKFAR11 ;
 label values FWPOKAGE11 FWPOKAGE11 ;
 label values FWPOKSEX12 FWPOKSEX12 ;
 label values FWPOKAD12 FWPOKAD12 ;
 label values FWPOKLIV89 FWPOKLIV89 ;
 label values FWPOKFAR12 FWPOKFAR12 ;
 label values FWPOKAGE12 FWPOKAGE12 ;
 label values FWPOKSEX13 FWPOKSEX13 ;
 label values FWPOKAD13 FWPOKAD13 ;
 label values FWPOKLIV97 FWPOKLIV97 ;
 label values FWPOKFAR13 FWPOKFAR13 ;
 label values FWPOKAGE13 FWPOKAGE13 ;
 label values FWPOKSEX14 FWPOKSEX14 ;
 label values FWPOKAD14 FWPOKAD14 ;
 label values FWPOKLIV105 FWPOKLIV105 ;
 label values FWPOKFAR14 FWPOKFAR14 ;
 label values FWPOKAGE14 FWPOKAGE14 ;
 label values FWPOKSEX15 FWPOKSEX15 ;
 label values FWPOKAD15 FWPOKAD15 ;
 label values FWPOKLIV113 FWPOKLIV113 ;
 label values FWPOKFAR15 FWPOKFAR15 ;
 label values FWPOKAGE15 FWPOKAGE15 ;
 label values E_OKAKIDS3 E_OKAKIDS3 ;
 label values FWPOTKID3 FWPOTKID3 ;
 label values FWPOKNUM3 FWPOKNUM3 ;
 label values FWPOKWTH3 FWPOKWTH3 ;
 label values FWPOKWTHN3 FWPOKWTHN3 ;
 label values FWPOKSEX21 FWPOKSEX21 ;
 label values FWPOKAD21 FWPOKAD21 ;
 label values FWPOKLIV161 FWPOKLIV161 ;
 label values FWPOKFAR21 FWPOKFAR21 ;
 label values FWPOKAGE21 FWPOKAGE21 ;
 label values FWPOKSEX22 FWPOKSEX22 ;
 label values FWPOKAD22 FWPOKAD22 ;
 label values FWPOKLIV169 FWPOKLIV169 ;
 label values FWPOKFAR22 FWPOKFAR22 ;
 label values FWPOKAGE22 FWPOKAGE22 ;
 label values E_OKAKIDS4 E_OKAKIDS4 ;
 label values FWPOTKID4 FWPOTKID4 ;
 label values FWPOKNUM4 FWPOKNUM4 ;
 label values FWPOKWTH4 FWPOKWTH4 ;
 label values FWPOKWTHN4 FWPOKWTHN4 ;
 label values FWPOKSEX31 FWPOKSEX31 ;
 label values FWPOKAD31 FWPOKAD31 ;
 label values FWPOKAGE31 FWPOKAGE31 ;
 label values E_OKAKIDS11 E_OKAKIDS11 ;
 label values FWPOTKID11 FWPOTKID11 ;
 label values FWPOKNUM11 FWPOKNUM11 ;
 label values FWPOKWTH11 FWPOKWTH11 ;
 label values FWPOKWTHN11 FWPOKWTHN11 ;
 label values FWPOKSEX101 FWPOKSEX101 ;
 label values FWPOKAD101 FWPOKAD101 ;
 label values FWPOKLIV801 FWPOKLIV801 ;
 label values FWPOKFAR101 FWPOKFAR101 ;
 label values FWPOKAGE101 FWPOKAGE101 ;
 label values FWPOKSEX102 FWPOKSEX102 ;
 label values FWPOKAD102 FWPOKAD102 ;
 label values FWPOKLIV809 FWPOKLIV809 ;
 label values FWPOKFAR102 FWPOKFAR102 ;
 label values FWPOKAGE102 FWPOKAGE102 ;
 label values FWPOKSEX103 FWPOKSEX103 ;
 label values FWPOKAD103 FWPOKAD103 ;
 label values FWPOKLIV817 FWPOKLIV817 ;
 label values FWPOKFAR103 FWPOKFAR103 ;
 label values FWPOKAGE103 FWPOKAGE103 ;
 label values FWPOKSEX104 FWPOKSEX104 ;
 label values FWPOKAD104 FWPOKAD104 ;
 label values FWPOKLIV825 FWPOKLIV825 ;
 label values FWPOKFAR104 FWPOKFAR104 ;
 label values FWPOKAGE104 FWPOKAGE104 ;
 label values FWPOKSEX105 FWPOKSEX105 ;
 label values FWPOKAD105 FWPOKAD105 ;
 label values FWPOKLIV833 FWPOKLIV833 ;
 label values FWPOKFAR105 FWPOKFAR105 ;
 label values FWPOKAGE105 FWPOKAGE105 ;
 label values FWPOKSEX106 FWPOKSEX106 ;
 label values FWPOKAD106 FWPOKAD106 ;
 label values FWPOKLIV841 FWPOKLIV841 ;
 label values FWPOKFAR106 FWPOKFAR106 ;
 label values FWPOKAGE106 FWPOKAGE106 ;
 label values E_NBAKIDS E_NBAKIDS ;
 label values FWPNBEVR FWPNBEVR ;
 label values FWPNBNUM FWPNBNUM ;
 label values FWPNBREL FWPNBREL ;
 label values FWPNBFOS FWPNBFOS ;
 label values FWPNBSEX FWPNBSEX ;
 label values FWPNBAD FWPNBAD ;
 label values FWPNBLIV1 FWPNBLIV1 ;
 label values FWPNBLIV2 FWPNBLIV2 ;
 label values FWPNBFAR FWPNBFAR ;
 label values FWPNBAGE FWPNBAGE ;
 label values FWPNBREL2 FWPNBREL2 ;
 label values FWPNBFOS2 FWPNBFOS2 ;
 label values FWPNBSEX2 FWPNBSEX2 ;
 label values FWPNBAD2 FWPNBAD2 ;
 label values FWPNBLIV9 FWPNBLIV9 ;
 label values FWPNBLIV10 FWPNBLIV10 ;
 label values FWPNBFAR2 FWPNBFAR2 ;
 label values FWPNBAGE2 FWPNBAGE2 ;
 label values FWPNBREL3 FWPNBREL3 ;
 label values FWPNBFOS3 FWPNBFOS3 ;
 label values FWPNBSEX3 FWPNBSEX3 ;
 label values FWPNBAD3 FWPNBAD3 ;
 label values FWPNBLIV17 FWPNBLIV17 ;
 label values FWPNBLIV18 FWPNBLIV18 ;
 label values FWPNBFAR3 FWPNBFAR3 ;
 label values FWPNBAGE3 FWPNBAGE3 ;
 label values FWPNBREL4 FWPNBREL4 ;
 label values FWPNBFOS4 FWPNBFOS4 ;
 label values FWPNBSEX4 FWPNBSEX4 ;
 label values FWPNBAD4 FWPNBAD4 ;
 label values FWPNBLIV25 FWPNBLIV25 ;
 label values FWPNBLIV26 FWPNBLIV26 ;
 label values FWPNBFAR4 FWPNBFAR4 ;
 label values FWPNBAGE4 FWPNBAGE4 ;
 label values E_NBAKIDS2 E_NBAKIDS2 ;
 label values FWPNBEVR2 FWPNBEVR2 ;
 label values FWPNBNUM2 FWPNBNUM2 ;
 label values FWPNBREL11 FWPNBREL11 ;
 label values FWPNBFOS11 FWPNBFOS11 ;
 label values FWPNBSEX11 FWPNBSEX11 ;
 label values FWPNBAD11 FWPNBAD11 ;
 label values FWPNBLIV81 FWPNBLIV81 ;
 label values FWPNBFAR11 FWPNBFAR11 ;
 label values FWPNBAGE11 FWPNBAGE11 ;
 label values FWPNBREL12 FWPNBREL12 ;
 label values FWPNBFOS12 FWPNBFOS12 ;
 label values FWPNBSEX12 FWPNBSEX12 ;
 label values FWPNBAD12 FWPNBAD12 ;
 label values FWPNBLIV89 FWPNBLIV89 ;
 label values FWPNBFAR12 FWPNBFAR12 ;
 label values FWPNBAGE12 FWPNBAGE12 ;
 label values E_NBAKIDS3 E_NBAKIDS3 ;
 label values FWPNBEVR3 FWPNBEVR3 ;
 label values FWPNBNUM3 FWPNBNUM3 ;
 label values FWPNBREL21 FWPNBREL21 ;
 label values FWPNBFOS21 FWPNBFOS21 ;
 label values FWPNBSEX21 FWPNBSEX21 ;
 label values FWPNBAD21 FWPNBAD21 ;
 label values FWPNBLIV161 FWPNBLIV161 ;
 label values FWPNBFAR21 FWPNBFAR21 ;
 label values FWPNBAGE21 FWPNBAGE21 ;
 label values FWPNBREL22 FWPNBREL22 ;
 label values FWPNBFOS22 FWPNBFOS22 ;
 label values FWPNBSEX22 FWPNBSEX22 ;
 label values FWPNBAD22 FWPNBAD22 ;
 label values FWPNBLIV169 FWPNBLIV169 ;
 label values FWPNBFAR22 FWPNBFAR22 ;
 label values FWPNBAGE22 FWPNBAGE22 ;
 label values E_NBAKIDS4 E_NBAKIDS4 ;
 label values FWPNBEVR4 FWPNBEVR4 ;
 label values E_NBAKIDS11 E_NBAKIDS11 ;
 label values FWPNBEVR11 FWPNBEVR11 ;
 label values FWPNBNUM11 FWPNBNUM11 ;
 label values FWPNBREL101 FWPNBREL101 ;
 label values FWPNBFOS101 FWPNBFOS101 ;
 label values FWPNBSEX101 FWPNBSEX101 ;
 label values FWPNBAD101 FWPNBAD101 ;
 label values FWPNBLIV801 FWPNBLIV801 ;
 label values FWPNBFAR101 FWPNBFAR101 ;
 label values FWPNBAGE101 FWPNBAGE101 ;
 label values FWPNBREL102 FWPNBREL102 ;
 label values FWPNBFOS102 FWPNBFOS102 ;
 label values FWPNBSEX102 FWPNBSEX102 ;
 label values FWPNBAD102 FWPNBAD102 ;
 label values FWPNBLIV809 FWPNBLIV809 ;
 label values FWPNBFAR102 FWPNBFAR102 ;
 label values FWPNBAGE102 FWPNBAGE102 ;
 label values FWPNBREL103 FWPNBREL103 ;
 label values FWPNBFOS103 FWPNBFOS103 ;
 label values FWPNBSEX103 FWPNBSEX103 ;
 label values FWPNBAD103 FWPNBAD103 ;
 label values FWPNBLIV817 FWPNBLIV817 ;
 label values FWPNBFAR103 FWPNBFAR103 ;
 label values FWPNBAGE103 FWPNBAGE103 ;
 label values FWPNBREL104 FWPNBREL104 ;
 label values FWPNBFOS104 FWPNBFOS104 ;
 label values FWPNBSEX104 FWPNBSEX104 ;
 label values FWPNBAD104 FWPNBAD104 ;
 label values FWPNBLIV825 FWPNBLIV825 ;
 label values FWPNBFAR104 FWPNBFAR104 ;
 label values FWPNBAGE104 FWPNBAGE104 ;
 label values OTBCHIL OTBCHIL ;
 label values OTBPROBE OTBPROBE ;
 label values OTBCHILN OTBCHILN ;
 label values OTBSAME OTBSAME ;
 label values OBCSEXX OBCSEXX ;
 label values OBCDOB_Y OBCDOB_Y ;
 label values OBCMAGEX OBCMAGEX ;
 label values OBCMLIV OBCMLIV ;
 label values OBCKNOWX OBCKNOWX ;
 label values OBCLIVEX01 OBCLIVEX01 ;
 label values OBCLIVEX02 OBCLIVEX02 ;
 label values OBCLIVEX03 OBCLIVEX03 ;
 label values OBCAGE OBCAGE ;
 label values OBCCHSIG OBCCHSIG ;
 label values OBCCHCRT OBCCHCRT ;
 label values OBCCHGEN OBCCHGEN ;
 label values OBCEVER OBCEVER ;
 label values OBCFAR OBCFAR ;
 label values OBCRWANX OBCRWANX ;
 label values OBCSOONX OBCSOONX ;
 label values OBCSOONN OBCSOONN ;
 label values OBCSOONMY OBCSOONMY ;
 label values OBCHPYX OBCHPYX ;
 label values OBCSEXX2 OBCSEXX2 ;
 label values OBCDOB_Y2 OBCDOB_Y2 ;
 label values MULTBIRT152 MULTBIRT152 ;
 label values OBCMAGEX2 OBCMAGEX2 ;
 label values OBCMLIV2 OBCMLIV2 ;
 label values OBCKNOWX2 OBCKNOWX2 ;
 label values OBCLIVEX11 OBCLIVEX11 ;
 label values OBCLIVEX12 OBCLIVEX12 ;
 label values OBCLIVEX13 OBCLIVEX13 ;
 label values OBCAGE2 OBCAGE2 ;
 label values OBCCHSIG2 OBCCHSIG2 ;
 label values OBCCHCRT2 OBCCHCRT2 ;
 label values OBCCHGEN2 OBCCHGEN2 ;
 label values OBCEVER2 OBCEVER2 ;
 label values OBCFAR2 OBCFAR2 ;
 label values OBCRWANX2 OBCRWANX2 ;
 label values OBCSOONX2 OBCSOONX2 ;
 label values OBCSOONN2 OBCSOONN2 ;
 label values OBCSOONMY2 OBCSOONMY2 ;
 label values OBCHPYX2 OBCHPYX2 ;
 label values OBCSEXX3 OBCSEXX3 ;
 label values OBCDOB_Y3 OBCDOB_Y3 ;
 label values MULTBIRT153 MULTBIRT153 ;
 label values OBCMAGEX3 OBCMAGEX3 ;
 label values OBCMLIV3 OBCMLIV3 ;
 label values OBCKNOWX3 OBCKNOWX3 ;
 label values OBCLIVEX21 OBCLIVEX21 ;
 label values OBCLIVEX22 OBCLIVEX22 ;
 label values OBCLIVEX23 OBCLIVEX23 ;
 label values OBCAGE3 OBCAGE3 ;
 label values OBCCHSIG3 OBCCHSIG3 ;
 label values OBCCHCRT3 OBCCHCRT3 ;
 label values OBCCHGEN3 OBCCHGEN3 ;
 label values OBCEVER3 OBCEVER3 ;
 label values OBCFAR3 OBCFAR3 ;
 label values OBCRWANX3 OBCRWANX3 ;
 label values OBCSOONX3 OBCSOONX3 ;
 label values OBCSOONN3 OBCSOONN3 ;
 label values OBCSOONMY3 OBCSOONMY3 ;
 label values OBCHPYX3 OBCHPYX3 ;
 label values OBCSEXX4 OBCSEXX4 ;
 label values OBCDOB_Y4 OBCDOB_Y4 ;
 label values MULTBIRT154 MULTBIRT154 ;
 label values OBCMAGEX4 OBCMAGEX4 ;
 label values OBCMLIV4 OBCMLIV4 ;
 label values OBCKNOWX4 OBCKNOWX4 ;
 label values OBCLIVEX31 OBCLIVEX31 ;
 label values OBCLIVEX32 OBCLIVEX32 ;
 label values OBCLIVEX33 OBCLIVEX33 ;
 label values OBCAGE4 OBCAGE4 ;
 label values OBCCHSIG4 OBCCHSIG4 ;
 label values OBCCHCRT4 OBCCHCRT4 ;
 label values OBCCHGEN4 OBCCHGEN4 ;
 label values OBCEVER4 OBCEVER4 ;
 label values OBCFAR4 OBCFAR4 ;
 label values OBCRWANX4 OBCRWANX4 ;
 label values OBCSOONX4 OBCSOONX4 ;
 label values OBCSOONN4 OBCSOONN4 ;
 label values OBCSOONMY4 OBCSOONMY4 ;
 label values OBCHPYX4 OBCHPYX4 ;
 label values OBCSEXX5 OBCSEXX5 ;
 label values OBCDOB_Y5 OBCDOB_Y5 ;
 label values MULTBIRT155 MULTBIRT155 ;
 label values OBCMAGEX5 OBCMAGEX5 ;
 label values OBCMLIV5 OBCMLIV5 ;
 label values OBCKNOWX5 OBCKNOWX5 ;
 label values OBCLIVEX41 OBCLIVEX41 ;
 label values OBCLIVEX42 OBCLIVEX42 ;
 label values OBCLIVEX43 OBCLIVEX43 ;
 label values OBCAGE5 OBCAGE5 ;
 label values OBCCHSIG5 OBCCHSIG5 ;
 label values OBCCHCRT5 OBCCHCRT5 ;
 label values OBCCHGEN5 OBCCHGEN5 ;
 label values OBCEVER5 OBCEVER5 ;
 label values OBCFAR5 OBCFAR5 ;
 label values OBCRWANX5 OBCRWANX5 ;
 label values OBCSOONX5 OBCSOONX5 ;
 label values OBCSOONN5 OBCSOONN5 ;
 label values OBCSOONMY5 OBCSOONMY5 ;
 label values OBCHPYX5 OBCHPYX5 ;
 label values OBCSEXX6 OBCSEXX6 ;
 label values OBCDOB_Y6 OBCDOB_Y6 ;
 label values MULTBIRT156 MULTBIRT156 ;
 label values OBCMAGEX6 OBCMAGEX6 ;
 label values OBCMLIV6 OBCMLIV6 ;
 label values OBCKNOWX6 OBCKNOWX6 ;
 label values OBCLIVEX51 OBCLIVEX51 ;
 label values OBCLIVEX52 OBCLIVEX52 ;
 label values OBCLIVEX53 OBCLIVEX53 ;
 label values OBCAGE6 OBCAGE6 ;
 label values OBCCHSIG6 OBCCHSIG6 ;
 label values OBCCHCRT6 OBCCHCRT6 ;
 label values OBCCHGEN6 OBCCHGEN6 ;
 label values OBCEVER6 OBCEVER6 ;
 label values OBCFAR6 OBCFAR6 ;
 label values OBCRWANX6 OBCRWANX6 ;
 label values OBCSOONX6 OBCSOONX6 ;
 label values OBCSOONN6 OBCSOONN6 ;
 label values OBCSOONMY6 OBCSOONMY6 ;
 label values OBCHPYX6 OBCHPYX6 ;
 label values OBCSEXX7 OBCSEXX7 ;
 label values OBCDOB_Y7 OBCDOB_Y7 ;
 label values MULTBIRT157 MULTBIRT157 ;
 label values OBCMAGEX7 OBCMAGEX7 ;
 label values OBCMLIV7 OBCMLIV7 ;
 label values OBCKNOWX7 OBCKNOWX7 ;
 label values OBCLIVEX61 OBCLIVEX61 ;
 label values OBCLIVEX62 OBCLIVEX62 ;
 label values OBCLIVEX63 OBCLIVEX63 ;
 label values OBCAGE7 OBCAGE7 ;
 label values OBCCHSIG7 OBCCHSIG7 ;
 label values OBCCHCRT7 OBCCHCRT7 ;
 label values OBCCHGEN7 OBCCHGEN7 ;
 label values OBCEVER7 OBCEVER7 ;
 label values OBCFAR7 OBCFAR7 ;
 label values OBCRWANX7 OBCRWANX7 ;
 label values OBCSOONX7 OBCSOONX7 ;
 label values OBCSOONN7 OBCSOONN7 ;
 label values OBCSOONMY7 OBCSOONMY7 ;
 label values OBCHPYX7 OBCHPYX7 ;
 label values OBCSEXX8 OBCSEXX8 ;
 label values OBCDOB_Y8 OBCDOB_Y8 ;
 label values MULTBIRT158 MULTBIRT158 ;
 label values OBCMAGEX8 OBCMAGEX8 ;
 label values OBCMLIV8 OBCMLIV8 ;
 label values OBCKNOWX8 OBCKNOWX8 ;
 label values OBCLIVEX71 OBCLIVEX71 ;
 label values OBCLIVEX72 OBCLIVEX72 ;
 label values OBCLIVEX73 OBCLIVEX73 ;
 label values OBCAGE8 OBCAGE8 ;
 label values OBCCHSIG8 OBCCHSIG8 ;
 label values OBCCHCRT8 OBCCHCRT8 ;
 label values OBCCHGEN8 OBCCHGEN8 ;
 label values OBCEVER8 OBCEVER8 ;
 label values OBCFAR8 OBCFAR8 ;
 label values OBCRWANX8 OBCRWANX8 ;
 label values OBCSOONX8 OBCSOONX8 ;
 label values OBCSOONN8 OBCSOONN8 ;
 label values OBCSOONMY8 OBCSOONMY8 ;
 label values OBCHPYX8 OBCHPYX8 ;
 label values OBCSEXX9 OBCSEXX9 ;
 label values OBCDOB_Y9 OBCDOB_Y9 ;
 label values MULTBIRT159 MULTBIRT159 ;
 label values OBCMAGEX9 OBCMAGEX9 ;
 label values OBCMLIV9 OBCMLIV9 ;
 label values OBCKNOWX9 OBCKNOWX9 ;
 label values OBCLIVEX81 OBCLIVEX81 ;
 label values OBCLIVEX82 OBCLIVEX82 ;
 label values OBCLIVEX83 OBCLIVEX83 ;
 label values OBCAGE9 OBCAGE9 ;
 label values OBCCHSIG9 OBCCHSIG9 ;
 label values OBCCHCRT9 OBCCHCRT9 ;
 label values OBCCHGEN9 OBCCHGEN9 ;
 label values OBCEVER9 OBCEVER9 ;
 label values OBCFAR9 OBCFAR9 ;
 label values OBCRWANX9 OBCRWANX9 ;
 label values OBCSOONX9 OBCSOONX9 ;
 label values OBCSOONN9 OBCSOONN9 ;
 label values OBCSOONMY9 OBCSOONMY9 ;
 label values OBCHPYX9 OBCHPYX9 ;
 label values OBCSEXX10 OBCSEXX10 ;
 label values OBCDOB_Y10 OBCDOB_Y10 ;
 label values MULTBIRT160 MULTBIRT160 ;
 label values OBCMAGEX10 OBCMAGEX10 ;
 label values OBCMLIV10 OBCMLIV10 ;
 label values OBCKNOWX10 OBCKNOWX10 ;
 label values OBCLIVEX91 OBCLIVEX91 ;
 label values OBCLIVEX92 OBCLIVEX92 ;
 label values OBCLIVEX93 OBCLIVEX93 ;
 label values OBCAGE10 OBCAGE10 ;
 label values OBCCHSIG10 OBCCHSIG10 ;
 label values OBCCHCRT10 OBCCHCRT10 ;
 label values OBCCHGEN10 OBCCHGEN10 ;
 label values OBCEVER10 OBCEVER10 ;
 label values OBCFAR10 OBCFAR10 ;
 label values OBCRWANX10 OBCRWANX10 ;
 label values OBCSOONX10 OBCSOONX10 ;
 label values OBCSOONN10 OBCSOONN10 ;
 label values OBCSOONMY10 OBCSOONMY10 ;
 label values OBCHPYX10 OBCHPYX10 ;
 label values F_AKIDS F_AKIDS ;
 label values OTACHIL OTACHIL ;
 label values OTACHILN OTACHILN ;
 label values OTNBREL OTNBREL ;
 label values OTNBFOS OTNBFOS ;
 label values OTNBSEX OTNBSEX ;
 label values OTNBAD OTNBAD ;
 label values OTNBLIV1 OTNBLIV1 ;
 label values OTNBLIV2 OTNBLIV2 ;
 label values OTNBFAR OTNBFAR ;
 label values OTNBAGE OTNBAGE ;
 label values OTNBREL2 OTNBREL2 ;
 label values OTNBFOS2 OTNBFOS2 ;
 label values OTNBSEX2 OTNBSEX2 ;
 label values OTNBAD2 OTNBAD2 ;
 label values OTNBLIV9 OTNBLIV9 ;
 label values OTNBLIV10 OTNBLIV10 ;
 label values OTNBFAR2 OTNBFAR2 ;
 label values OTNBAGE2 OTNBAGE2 ;
 label values OTNBREL3 OTNBREL3 ;
 label values OTNBFOS3 OTNBFOS3 ;
 label values OTNBSEX3 OTNBSEX3 ;
 label values OTNBAD3 OTNBAD3 ;
 label values OTNBLIV17 OTNBLIV17 ;
 label values OTNBLIV18 OTNBLIV18 ;
 label values OTNBFAR3 OTNBFAR3 ;
 label values OTNBAGE3 OTNBAGE3 ;
 label values OTNBREL4 OTNBREL4 ;
 label values OTNBFOS4 OTNBFOS4 ;
 label values OTNBSEX4 OTNBSEX4 ;
 label values OTNBAD4 OTNBAD4 ;
 label values OTNBLIV25 OTNBLIV25 ;
 label values OTNBLIV26 OTNBLIV26 ;
 label values OTNBFAR4 OTNBFAR4 ;
 label values OTNBAGE4 OTNBAGE4 ;
 label values OTNBREL5 OTNBREL5 ;
 label values OTNBFOS5 OTNBFOS5 ;
 label values OTNBSEX5 OTNBSEX5 ;
 label values OTNBAD5 OTNBAD5 ;
 label values OTNBLIV33 OTNBLIV33 ;
 label values OTNBLIV34 OTNBLIV34 ;
 label values OTNBFAR5 OTNBFAR5 ;
 label values OTNBAGE5 OTNBAGE5 ;
 label values OTNBREL6 OTNBREL6 ;
 label values OTNBFOS6 OTNBFOS6 ;
 label values OTNBSEX6 OTNBSEX6 ;
 label values OTNBAD6 OTNBAD6 ;
 label values OTNBLIV41 OTNBLIV41 ;
 label values OTNBLIV42 OTNBLIV42 ;
 label values OTNBFAR6 OTNBFAR6 ;
 label values OTNBAGE6 OTNBAGE6 ;
 label values OTNBREL7 OTNBREL7 ;
 label values OTNBFOS7 OTNBFOS7 ;
 label values OTNBSEX7 OTNBSEX7 ;
 label values OTNBAD7 OTNBAD7 ;
 label values OTNBLIV49 OTNBLIV49 ;
 label values OTNBLIV50 OTNBLIV50 ;
 label values OTNBFAR7 OTNBFAR7 ;
 label values OTNBAGE7 OTNBAGE7 ;
 label values OTNBREL8 OTNBREL8 ;
 label values OTNBFOS8 OTNBFOS8 ;
 label values OTNBSEX8 OTNBSEX8 ;
 label values OTNBAD8 OTNBAD8 ;
 label values OTNBLIV57 OTNBLIV57 ;
 label values OTNBLIV58 OTNBLIV58 ;
 label values OTNBFAR8 OTNBFAR8 ;
 label values OTNBAGE8 OTNBAGE8 ;
 label values OTPREG OTPREG ;
 label values OTPRGPRB OTPRGPRB ;
 label values OTPRGN OTPRGN ;
 label values OTPRGEND OTPRGEND ;
 label values OTMSN OTMSN ;
 label values OTSTN OTSTN ;
 label values OTABN OTABN ;
 label values TOTPRG TOTPRG ;
 label values OTPREGS OTPREGS ;
 label values TOTPREGS_C TOTPREGS_C ;
 label values TOTPREGS_R TOTPREGS_R ;
 label values BIOKIDS BIOKIDS ;
 label values ADOPKIDS ADOPKIDS ;
 label values ANYKIDS ANYKIDS ;
 label values BIOADOPT BIOADOPT ;
 label values PREGSNOW PREGSNOW ;
 label values NUMLIFE NUMLIFE ;
 label values BIODOB1 BIODOB1 ;
 label values BIODOB2 BIODOB2 ;
 label values BIODOB3 BIODOB3 ;
 label values BIODOB4 BIODOB4 ;
 label values BIODOB5 BIODOB5 ;
 label values BIODOB6 BIODOB6 ;
 label values BIODOB7 BIODOB7 ;
 label values BIODOB8 BIODOB8 ;
 label values BIODOB9 BIODOB9 ;
 label values BIODOB10 BIODOB10 ;
 label values BIOSEX1 BIOSEX1 ;
 label values BIOSEX2 BIOSEX2 ;
 label values BIOSEX3 BIOSEX3 ;
 label values BIOSEX4 BIOSEX4 ;
 label values BIOSEX5 BIOSEX5 ;
 label values BIOSEX6 BIOSEX6 ;
 label values BIOSEX7 BIOSEX7 ;
 label values BIOSEX8 BIOSEX8 ;
 label values BIOSEX9 BIOSEX9 ;
 label values BIOSEX10 BIOSEX10 ;
 label values BIOAGE1 BIOAGE1 ;
 label values BIOAGE2 BIOAGE2 ;
 label values BIOAGE3 BIOAGE3 ;
 label values BIOAGE4 BIOAGE4 ;
 label values BIOAGE5 BIOAGE5 ;
 label values BIOAGE6 BIOAGE6 ;
 label values BIOAGE7 BIOAGE7 ;
 label values BIOAGE8 BIOAGE8 ;
 label values BIOAGE9 BIOAGE9 ;
 label values BIOAGE10 BIOAGE10 ;
 label values BIOAGEGP1 BIOAGEGP1 ;
 label values BIOAGEGP2 BIOAGEGP2 ;
 label values BIOAGEGP3 BIOAGEGP3 ;
 label values BIOAGEGP4 BIOAGEGP4 ;
 label values BIOAGEGP5 BIOAGEGP5 ;
 label values BIOAGEGP6 BIOAGEGP6 ;
 label values BIOAGEGP7 BIOAGEGP7 ;
 label values BIOAGEGP8 BIOAGEGP8 ;
 label values BIOAGEGP9 BIOAGEGP9 ;
 label values BIOAGEGP10 BIOAGEGP10 ;
 label values BIOHH1 BIOHH1 ;
 label values BIOHH2 BIOHH2 ;
 label values BIOHH3 BIOHH3 ;
 label values BIOHH4 BIOHH4 ;
 label values BIOHH5 BIOHH5 ;
 label values BIOHH6 BIOHH6 ;
 label values BIOHH7 BIOHH7 ;
 label values BIOHH8 BIOHH8 ;
 label values BIOHH9 BIOHH9 ;
 label values BIOHH10 BIOHH10 ;
 label values BIOMOM1 BIOMOM1 ;
 label values BIOMOM2 BIOMOM2 ;
 label values BIOMOM3 BIOMOM3 ;
 label values BIOMOM4 BIOMOM4 ;
 label values BIOMOM5 BIOMOM5 ;
 label values BIOMOM6 BIOMOM6 ;
 label values BIOMOM7 BIOMOM7 ;
 label values BIOMOM8 BIOMOM8 ;
 label values BIOMOM9 BIOMOM9 ;
 label values BIOMOM10 BIOMOM10 ;
 label values BIOMAR1 BIOMAR1 ;
 label values BIOMAR2 BIOMAR2 ;
 label values BIOMAR3 BIOMAR3 ;
 label values BIOMAR4 BIOMAR4 ;
 label values BIOMAR5 BIOMAR5 ;
 label values BIOMAR6 BIOMAR6 ;
 label values BIOMAR7 BIOMAR7 ;
 label values BIOMAR8 BIOMAR8 ;
 label values BIOMAR9 BIOMAR9 ;
 label values BIOMAR10 BIOMAR10 ;
 label values BIOCOHB1 BIOCOHB1 ;
 label values BIOCOHB2 BIOCOHB2 ;
 label values BIOCOHB3 BIOCOHB3 ;
 label values BIOCOHB4 BIOCOHB4 ;
 label values BIOCOHB5 BIOCOHB5 ;
 label values BIOCOHB6 BIOCOHB6 ;
 label values BIOCOHB7 BIOCOHB7 ;
 label values BIOCOHB8 BIOCOHB8 ;
 label values BIOCOHB9 BIOCOHB9 ;
 label values BIOCOHB10 BIOCOHB10 ;
 label values BIOLRNPG1 BIOLRNPG1 ;
 label values BIOLRNPG2 BIOLRNPG2 ;
 label values BIOLRNPG3 BIOLRNPG3 ;
 label values BIOLRNPG4 BIOLRNPG4 ;
 label values BIOLRNPG5 BIOLRNPG5 ;
 label values BIOLRNPG6 BIOLRNPG6 ;
 label values BIOLRNPG7 BIOLRNPG7 ;
 label values BIOLRNPG8 BIOLRNPG8 ;
 label values BIOLRNPG9 BIOLRNPG9 ;
 label values BIOLRNPG10 BIOLRNPG10 ;
 label values BIOLIVNG11 BIOLIVNG11 ;
 label values BIOLIVNG12 BIOLIVNG12 ;
 label values BIOLIVNG13 BIOLIVNG13 ;
 label values BIOLIVNG21 BIOLIVNG21 ;
 label values BIOLIVNG22 BIOLIVNG22 ;
 label values BIOLIVNG23 BIOLIVNG23 ;
 label values BIOLIVNG31 BIOLIVNG31 ;
 label values BIOLIVNG32 BIOLIVNG32 ;
 label values BIOLIVNG33 BIOLIVNG33 ;
 label values BIOLIVNG41 BIOLIVNG41 ;
 label values BIOLIVNG42 BIOLIVNG42 ;
 label values BIOLIVNG43 BIOLIVNG43 ;
 label values BIOLIVNG51 BIOLIVNG51 ;
 label values BIOLIVNG52 BIOLIVNG52 ;
 label values BIOLIVNG53 BIOLIVNG53 ;
 label values BIOLIVNG61 BIOLIVNG61 ;
 label values BIOLIVNG62 BIOLIVNG62 ;
 label values BIOLIVNG63 BIOLIVNG63 ;
 label values BIOLIVNG71 BIOLIVNG71 ;
 label values BIOLIVNG72 BIOLIVNG72 ;
 label values BIOLIVNG73 BIOLIVNG73 ;
 label values BIOLIVNG81 BIOLIVNG81 ;
 label values BIOLIVNG82 BIOLIVNG82 ;
 label values BIOLIVNG83 BIOLIVNG83 ;
 label values BIOLIVNG91 BIOLIVNG91 ;
 label values BIOLIVNG92 BIOLIVNG92 ;
 label values BIOLIVNG93 BIOLIVNG93 ;
 label values BIOLIVNG101 BIOLIVNG101 ;
 label values BIOLIVNG102 BIOLIVNG102 ;
 label values BIOLIVNG103 BIOLIVNG103 ;
 label values BIOCHSIG1 BIOCHSIG1 ;
 label values BIOCHSIG2 BIOCHSIG2 ;
 label values BIOCHSIG3 BIOCHSIG3 ;
 label values BIOCHSIG4 BIOCHSIG4 ;
 label values BIOCHSIG5 BIOCHSIG5 ;
 label values BIOCHSIG6 BIOCHSIG6 ;
 label values BIOCHSIG7 BIOCHSIG7 ;
 label values BIOCHSIG8 BIOCHSIG8 ;
 label values BIOCHSIG9 BIOCHSIG9 ;
 label values BIOCHSIG10 BIOCHSIG10 ;
 label values BIOCHCRT1 BIOCHCRT1 ;
 label values BIOCHCRT2 BIOCHCRT2 ;
 label values BIOCHCRT3 BIOCHCRT3 ;
 label values BIOCHCRT4 BIOCHCRT4 ;
 label values BIOCHCRT5 BIOCHCRT5 ;
 label values BIOCHCRT6 BIOCHCRT6 ;
 label values BIOCHCRT7 BIOCHCRT7 ;
 label values BIOCHCRT8 BIOCHCRT8 ;
 label values BIOCHCRT9 BIOCHCRT9 ;
 label values BIOCHCRT10 BIOCHCRT10 ;
 label values BIOCHGEN1 BIOCHGEN1 ;
 label values BIOCHGEN2 BIOCHGEN2 ;
 label values BIOCHGEN3 BIOCHGEN3 ;
 label values BIOCHGEN4 BIOCHGEN4 ;
 label values BIOCHGEN5 BIOCHGEN5 ;
 label values BIOCHGEN6 BIOCHGEN6 ;
 label values BIOCHGEN7 BIOCHGEN7 ;
 label values BIOCHGEN8 BIOCHGEN8 ;
 label values BIOCHGEN9 BIOCHGEN9 ;
 label values BIOCHGEN10 BIOCHGEN10 ;
 label values BIOLVEVR1 BIOLVEVR1 ;
 label values BIOLVEVR2 BIOLVEVR2 ;
 label values BIOLVEVR3 BIOLVEVR3 ;
 label values BIOLVEVR4 BIOLVEVR4 ;
 label values BIOLVEVR5 BIOLVEVR5 ;
 label values BIOLVEVR6 BIOLVEVR6 ;
 label values BIOLVEVR7 BIOLVEVR7 ;
 label values BIOLVEVR8 BIOLVEVR8 ;
 label values BIOLVEVR9 BIOLVEVR9 ;
 label values BIOLVEVR10 BIOLVEVR10 ;
 label values BIOHWFAR1 BIOHWFAR1 ;
 label values BIOHWFAR2 BIOHWFAR2 ;
 label values BIOHWFAR3 BIOHWFAR3 ;
 label values BIOHWFAR4 BIOHWFAR4 ;
 label values BIOHWFAR5 BIOHWFAR5 ;
 label values BIOHWFAR6 BIOHWFAR6 ;
 label values BIOHWFAR7 BIOHWFAR7 ;
 label values BIOHWFAR8 BIOHWFAR8 ;
 label values BIOHWFAR9 BIOHWFAR9 ;
 label values BIOHWFAR10 BIOHWFAR10 ;
 label values BIOWANT1 BIOWANT1 ;
 label values BIOWANT2 BIOWANT2 ;
 label values BIOWANT3 BIOWANT3 ;
 label values BIOWANT4 BIOWANT4 ;
 label values BIOWANT5 BIOWANT5 ;
 label values BIOWANT6 BIOWANT6 ;
 label values BIOWANT7 BIOWANT7 ;
 label values BIOWANT8 BIOWANT8 ;
 label values BIOWANT9 BIOWANT9 ;
 label values BIOWANT10 BIOWANT10 ;
 label values BIOHSOON1 BIOHSOON1 ;
 label values BIOHSOON2 BIOHSOON2 ;
 label values BIOHSOON3 BIOHSOON3 ;
 label values BIOHSOON4 BIOHSOON4 ;
 label values BIOHSOON5 BIOHSOON5 ;
 label values BIOHSOON6 BIOHSOON6 ;
 label values BIOHSOON7 BIOHSOON7 ;
 label values BIOHSOON8 BIOHSOON8 ;
 label values BIOHSOON9 BIOHSOON9 ;
 label values BIOHSOON10 BIOHSOON10 ;
 label values BIOHOWSN1 BIOHOWSN1 ;
 label values BIOHOWSN2 BIOHOWSN2 ;
 label values BIOHOWSN3 BIOHOWSN3 ;
 label values BIOHOWSN4 BIOHOWSN4 ;
 label values BIOHOWSN5 BIOHOWSN5 ;
 label values BIOHOWSN6 BIOHOWSN6 ;
 label values BIOHOWSN7 BIOHOWSN7 ;
 label values BIOHOWSN8 BIOHOWSN8 ;
 label values BIOHOWSN9 BIOHOWSN9 ;
 label values BIOHOWSN10 BIOHOWSN10 ;
 label values BIOHPYPG1 BIOHPYPG1 ;
 label values BIOHPYPG2 BIOHPYPG2 ;
 label values BIOHPYPG3 BIOHPYPG3 ;
 label values BIOHPYPG4 BIOHPYPG4 ;
 label values BIOHPYPG5 BIOHPYPG5 ;
 label values BIOHPYPG6 BIOHPYPG6 ;
 label values BIOHPYPG7 BIOHPYPG7 ;
 label values BIOHPYPG8 BIOHPYPG8 ;
 label values BIOHPYPG9 BIOHPYPG9 ;
 label values BIOHPYPG10 BIOHPYPG10 ;
 label values CRALL CRALL ;
 label values CRALLU5 CRALLU5 ;
 label values CRALL518 CRALL518 ;
 label values CRMALU5 CRMALU5 ;
 label values CRMAL518 CRMAL518 ;
 label values CRFEMU5 CRFEMU5 ;
 label values CRFEM518 CRFEM518 ;
 label values NCALL NCALL ;
 label values NCALLU5 NCALLU5 ;
 label values NCALL518 NCALL518 ;
 label values NCMALU5 NCMALU5 ;
 label values NCMAL518 NCMAL518 ;
 label values NCFEMU5 NCFEMU5 ;
 label values NCFEM518 NCFEM518 ;
 label values RFAGE RFAGE ;
 label values RFSEX RFSEX ;
 label values ROUTG04 ROUTG04 ;
 label values RMEAL04 RMEAL04 ;
 label values RERRAND04 RERRAND04 ;
 label values RPLAY04 RPLAY04 ;
 label values RREAD04 RREAD04 ;
 label values RAFFECT04 RAFFECT04 ;
 label values RPRAISE04 RPRAISE04 ;
 label values RFEED04 RFEED04 ;
 label values RBATH04 RBATH04 ;
 label values RDIAPER04 RDIAPER04 ;
 label values RBED04 RBED04 ;
 label values RAPPT04 RAPPT04 ;
 label values RDISC04 RDISC04 ;
 label values ROUTG518 ROUTG518 ;
 label values RMEAL518 RMEAL518 ;
 label values RERRAND518 RERRAND518 ;
 label values RAFFECT518 RAFFECT518 ;
 label values RPRAISE518 RPRAISE518 ;
 label values RTAKE518 RTAKE518 ;
 label values RAPPT518 RAPPT518 ;
 label values RHELP518 RHELP518 ;
 label values RDISC518 RDISC518 ;
 label values RCLFR518 RCLFR518 ;
 label values RDO518 RDO518 ;
 label values NRFAGE NRFAGE ;
 label values NRFSEX NRFSEX ;
 label values NRVISIT04 NRVISIT04 ;
 label values NRSATVIS04 NRSATVIS04 ;
 label values NROUTG04 NROUTG04 ;
 label values NRMEAL04 NRMEAL04 ;
 label values NRERRAND04 NRERRAND04 ;
 label values NROVRNT04 NROVRNT04 ;
 label values NRPLAY04 NRPLAY04 ;
 label values NRREAD04 NRREAD04 ;
 label values NRAFFECT04 NRAFFECT04 ;
 label values NRPRAISE04 NRPRAISE04 ;
 label values NRFEED04 NRFEED04 ;
 label values NRBATH04 NRBATH04 ;
 label values NRDIAPER04 NRDIAPER04 ;
 label values NRBED04 NRBED04 ;
 label values NRAPPT04 NRAPPT04 ;
 label values NRDISC04 NRDISC04 ;
 label values NRVISIT518 NRVISIT518 ;
 label values NRSATVIS518 NRSATVIS518 ;
 label values NROUTG518 NROUTG518 ;
 label values NRMEAL518 NRMEAL518 ;
 label values NRERRAND518 NRERRAND518 ;
 label values NROVRNT518 NROVRNT518 ;
 label values NRAFFECT518 NRAFFECT518 ;
 label values NRPRAISE518 NRPRAISE518 ;
 label values NRTAKE518 NRTAKE518 ;
 label values NRAPPT518 NRAPPT518 ;
 label values NRHELP518 NRHELP518 ;
 label values NRDISC518 NRDISC518 ;
 label values NRCLFR518 NRCLFR518 ;
 label values NRDO518 NRDO518 ;
 label values NRMONEY NRMONEY ;
 label values NREG NREG ;
 label values NRAGREE NRAGREE ;
 label values NRCHSUPPYR NRCHSUPPYR ;
 label values COPARENT COPARENT ;
 label values RWANT RWANT ;
 label values PROBWANT PROBWANT ;
 label values JINTEND JINTEND ;
 label values JSUREINT JSUREINT ;
 label values JINTENDN JINTENDN ;
 label values JEXPECTL JEXPECTL ;
 label values JEXPECTS JEXPECTS ;
 label values JINTNEXT JINTNEXT ;
 label values INTEND INTEND ;
 label values INTENDN INTENDN ;
 label values EXPECTL EXPECTL ;
 label values EXPECTS EXPECTS ;
 label values INTNEXT INTNEXT ;
 label values USUALCAR USUALCAR ;
 label values USLPLACE USLPLACE ;
 label values USL12MOS USL12MOS ;
 label values CURRCOV CURRCOV ;
 label values COVERHOW01 COVERHOW01 ;
 label values COVERHOW02 COVERHOW02 ;
 label values COVERHOW03 COVERHOW03 ;
 label values COVERHOW04 COVERHOW04 ;
 label values PARINSUR PARINSUR ;
 label values INS_EXCH INS_EXCH ;
 label values INS_PREM INS_PREM ;
 label values COVER12 COVER12 ;
 label values NUMNOCOV NUMNOCOV ;
 label values YOUGOFPC YOUGOFPC ;
 label values WHENGOFP WHENGOFP ;
 label values YOUFPSVC1 YOUFPSVC1 ;
 label values YOUFPSVC2 YOUFPSVC2 ;
 label values YOUFPSVC3 YOUFPSVC3 ;
 label values YOUFPSVC4 YOUFPSVC4 ;
 label values YOUFPSVC5 YOUFPSVC5 ;
 label values YOUFPSVC6 YOUFPSVC6 ;
 label values DEAF DEAF ;
 label values BLIND BLIND ;
 label values DIFDECIDE DIFDECIDE ;
 label values DIFWALK DIFWALK ;
 label values DIFDRESS DIFDRESS ;
 label values DIFOUT DIFOUT ;
 label values EVRCANCER EVRCANCER ;
 label values AGECANCER AGECANCER ;
 label values CANCTYPE CANCTYPE ;
 label values ALCORISK ALCORISK ;
 label values VISIT12MO1 VISIT12MO1 ;
 label values VISIT12MO2 VISIT12MO2 ;
 label values VISIT12MO3 VISIT12MO3 ;
 label values SVC12MO1 SVC12MO1 ;
 label values SVC12MO2 SVC12MO2 ;
 label values SVC12MO3 SVC12MO3 ;
 label values SVC12MO4 SVC12MO4 ;
 label values SVC12MO5 SVC12MO5 ;
 label values SVC12MO6 SVC12MO6 ;
 label values SVC12MO7 SVC12MO7 ;
 label values SVC12MO8 SVC12MO8 ;
 label values NUMVISIT NUMVISIT ;
 label values PLACEVIS01 PLACEVIS01 ;
 label values PLACEVIS02 PLACEVIS02 ;
 label values PLACEVIS03 PLACEVIS03 ;
 label values PLACEVIS04 PLACEVIS04 ;
 label values PLACEVIS05 PLACEVIS05 ;
 label values PLACEVIS06 PLACEVIS06 ;
 label values SVCPAY1 SVCPAY1 ;
 label values SVCPAY2 SVCPAY2 ;
 label values SVCPAY3 SVCPAY3 ;
 label values SVCPAY4 SVCPAY4 ;
 label values SVCPAY5 SVCPAY5 ;
 label values TALKSA TALKSA ;
 label values TALKEC TALKEC ;
 label values TALKDM TALKDM ;
 label values WHYPSTD WHYPSTD ;
 label values BARRIER1 BARRIER1 ;
 label values BARRIER2 BARRIER2 ;
 label values BARRIER3 BARRIER3 ;
 label values BARRIER4 BARRIER4 ;
 label values BLDPRESS BLDPRESS ;
 label values HIGHBP HIGHBP ;
 label values BPMEDS BPMEDS ;
 label values ASKSMOKE ASKSMOKE ;
 label values INFHELP INFHELP ;
 label values INFSVCS1 INFSVCS1 ;
 label values INFSVCS2 INFSVCS2 ;
 label values INFSVCS3 INFSVCS3 ;
 label values INFSVCS4 INFSVCS4 ;
 label values INFSVCS5 INFSVCS5 ;
 label values INFSVCS6 INFSVCS6 ;
 label values INFTEST INFTEST ;
 label values WHOINSEM WHOINSEM ;
 label values INFHLPNW INFHLPNW ;
 label values LASTVIS_M LASTVIS_M ;
 label values LASTVIS_Y LASTVIS_Y ;
 label values CMINFVIS CMINFVIS ;
 label values INFRTHIS_1 INFRTHIS_1 ;
 label values INFRTHIS_2 INFRTHIS_2 ;
 label values DONBLOOD DONBLOOD ;
 label values HIVTEST HIVTEST ;
 label values NOHIVTST NOHIVTST ;
 label values WHENHIV_M WHENHIV_M ;
 label values WHENHIV_Y WHENHIV_Y ;
 label values CMHIVTST CMHIVTST ;
 label values HIVTSTYR HIVTSTYR ;
 label values HIVRESULT HIVRESULT ;
 label values WHYNOGET WHYNOGET ;
 label values PLCHIV PLCHIV ;
 label values RHHIVT1 RHHIVT1 ;
 label values RHHIVT21 RHHIVT21 ;
 label values HIVTST HIVTST ;
 label values WHOSUGG WHOSUGG ;
 label values TALKDOCT TALKDOCT ;
 label values AIDSTALK01 AIDSTALK01 ;
 label values AIDSTALK02 AIDSTALK02 ;
 label values AIDSTALK03 AIDSTALK03 ;
 label values AIDSTALK04 AIDSTALK04 ;
 label values AIDSTALK05 AIDSTALK05 ;
 label values AIDSTALK06 AIDSTALK06 ;
 label values AIDSTALK07 AIDSTALK07 ;
 label values AIDSTALK08 AIDSTALK08 ;
 label values AIDSTALK09 AIDSTALK09 ;
 label values AIDSTALK10 AIDSTALK10 ;
 label values AIDSTALK11 AIDSTALK11 ;
 label values SAMEADD SAMEADD ;
 label values CNTRY10 CNTRY10 ;
 label values BRNOUT BRNOUT ;
 label values YRSTRUS YRSTRUS ;
 label values RELRAISD RELRAISD ;
 label values ATTND14 ATTND14 ;
 label values RELCURR RELCURR ;
 label values RELTRAD RELTRAD ;
 label values FUNDAM1 FUNDAM1 ;
 label values FUNDAM2 FUNDAM2 ;
 label values FUNDAM3 FUNDAM3 ;
 label values FUNDAM4 FUNDAM4 ;
 label values RELDLIFE RELDLIFE ;
 label values ATTNDNOW ATTNDNOW ;
 label values MILSVC MILSVC ;
 label values WRK12MOS WRK12MOS ;
 label values FPT12MOS FPT12MOS ;
 label values DOLASTWK1 DOLASTWK1 ;
 label values DOLASTWK2 DOLASTWK2 ;
 label values DOLASTWK3 DOLASTWK3 ;
 label values DOLASTWK4 DOLASTWK4 ;
 label values DOLASTWK5 DOLASTWK5 ;
 label values DOLASTWK6 DOLASTWK6 ;
 label values RWRKST RWRKST ;
 label values WORKP12 WORKP12 ;
 label values RPAYJOB RPAYJOB ;
 label values RNUMJOB RNUMJOB ;
 label values RFTPTX RFTPTX ;
 label values REARNTY REARNTY ;
 label values SPLSTWK1 SPLSTWK1 ;
 label values SPLSTWK2 SPLSTWK2 ;
 label values SPLSTWK3 SPLSTWK3 ;
 label values SPLSTWK4 SPLSTWK4 ;
 label values SPLSTWK5 SPLSTWK5 ;
 label values SPWRKST SPWRKST ;
 label values SPPAYJOB SPPAYJOB ;
 label values SPNUMJOB SPNUMJOB ;
 label values SPFTPTX SPFTPTX ;
 label values SPEARNTY SPEARNTY ;
 label values SAMESEX SAMESEX ;
 label values CHSUPPOR CHSUPPOR ;
 label values REACTSLF REACTSLF ;
 label values CHBOTHER CHBOTHER ;
 label values SEXNEEDS SEXNEEDS ;
 label values WHENSICK WHENSICK ;
 label values SHOWPAIN SHOWPAIN ;
 label values PMARCOHB PMARCOHB ;
 label values COHCHANCE COHCHANCE ;
 label values MARRCHANCE MARRCHANCE ;
 label values PMARCOH PMARCOH ;
 label values ACASILANG ACASILANG ;
 label values GENHEALT GENHEALT ;
 label values INCHES INCHES ;
 label values RWEIGHT RWEIGHT ;
 label values BMI BMI ;
 label values DRWEIGH DRWEIGH ;
 label values TELLWGHT TELLWGHT ;
 label values WGHTSCRN WGHTSCRN ;
 label values ENGSPEAK ENGSPEAK ;
 label values NOBEDYR NOBEDYR ;
 label values STAYREL STAYREL ;
 label values JAILED JAILED ;
 label values JAILED2 JAILED2 ;
 label values FRQJAIL FRQJAIL ;
 label values FRQJAIL2 FRQJAIL2 ;
 label values EVSUSPEN EVSUSPEN ;
 label values GRADSUSP GRADSUSP ;
 label values SMK100 SMK100 ;
 label values AGESMK AGESMK ;
 label values SMOKE12 SMOKE12 ;
 label values SMKSTOP SMKSTOP ;
 label values DRINK12 DRINK12 ;
 label values UNIT30D UNIT30D ;
 label values DRINK30D DRINK30D ;
 label values DRINKDAY DRINKDAY ;
 label values BINGE30 BINGE30 ;
 label values DRNKMOST DRNKMOST ;
 label values BINGE12 BINGE12 ;
 label values POT12 POT12 ;
 label values COC12 COC12 ;
 label values CRACK12 CRACK12 ;
 label values CRYSTMTH12 CRYSTMTH12 ;
 label values INJECT12 INJECT12 ;
 label values MADEPREG MADEPREG ;
 label values PREGTOT2 PREGTOT2 ;
 label values PREGACASI PREGACASI ;
 label values NUMABORT NUMABORT ;
 label values NUMLIVEB NUMLIVEB ;
 label values TOLDPREG TOLDPREG ;
 label values WHATHAPP WHATHAPP ;
 label values FEMTOUCH FEMTOUCH ;
 label values VAGSEX VAGSEX ;
 label values AGEVAGR AGEVAGR ;
 label values CONDVAG CONDVAG ;
 label values COND1BRK COND1BRK ;
 label values COND1OFF COND1OFF ;
 label values WHYCONDL WHYCONDL ;
 label values GETORALF GETORALF ;
 label values CONDFELL CONDFELL ;
 label values GIVORALF GIVORALF ;
 label values ANYORAL ANYORAL ;
 label values TIMING TIMING ;
 label values ANALSEX ANALSEX ;
 label values CONDANAL CONDANAL ;
 label values OPPSEXANY OPPSEXANY ;
 label values OPPSEXGEN OPPSEXGEN ;
 label values CONDSEXL CONDSEXL ;
 label values WANTSEX1 WANTSEX1 ;
 label values HOWOLD HOWOLD ;
 label values EVRFORCD EVRFORCD ;
 label values AGEFORC1 AGEFORC1 ;
 label values GIVNDRG2 GIVNDRG2 ;
 label values SHEBIGOL SHEBIGOL ;
 label values ENDRELA2 ENDRELA2 ;
 label values WRDPRES2 WRDPRES2 ;
 label values THRTPHY2 THRTPHY2 ;
 label values PHYSHRT2 PHYSHRT2 ;
 label values HELDDWN2 HELDDWN2 ;
 label values PARTSLIF_1 PARTSLIF_1 ;
 label values PARTSLFV PARTSLFV ;
 label values PARTSLIF_2 PARTSLIF_2 ;
 label values OPPLIFENUM OPPLIFENUM ;
 label values PARTS12_1 PARTS12_1 ;
 label values PARTS12V PARTS12V ;
 label values PARTS12_2 PARTS12_2 ;
 label values OPPYEARNUM OPPYEARNUM ;
 label values NEWYEAR NEWYEAR ;
 label values NEWLIFE NEWLIFE ;
 label values VAGNUM12 VAGNUM12 ;
 label values ORALNUM12 ORALNUM12 ;
 label values ANALNUM12 ANALNUM12 ;
 label values NONMONOG NONMONOG ;
 label values NNONMONOG1 NNONMONOG1 ;
 label values NNONMONOG2 NNONMONOG2 ;
 label values NNONMONOG3 NNONMONOG3 ;
 label values FEMSHT12 FEMSHT12 ;
 label values JOHNFREQ JOHNFREQ ;
 label values PROSTFRQ PROSTFRQ ;
 label values HIVFEM12 HIVFEM12 ;
 label values GIVORALM GIVORALM ;
 label values GETORALM GETORALM ;
 label values ORALCONDM ORALCONDM ;
 label values ANALSEX2 ANALSEX2 ;
 label values ANALCONDM1 ANALCONDM1 ;
 label values ANALSEX3 ANALSEX3 ;
 label values ANALCONDM2 ANALCONDM2 ;
 label values MALESEX MALESEX ;
 label values SAMESEXANY SAMESEXANY ;
 label values MALPRTAGE MALPRTAGE ;
 label values MALPRTHRACE MALPRTHRACE ;
 label values EVRFORC2 EVRFORC2 ;
 label values AGEFORC2 AGEFORC2 ;
 label values GIVNDRG3 GIVNDRG3 ;
 label values HEBIGOLD HEBIGOLD ;
 label values ENDRELA3 ENDRELA3 ;
 label values WRDPRES3 WRDPRES3 ;
 label values THRTPHY3 THRTPHY3 ;
 label values PHYSHRT3 PHYSHRT3 ;
 label values HELDDWN3 HELDDWN3 ;
 label values MALEPRTS_1 MALEPRTS_1 ;
 label values MALEPRTSV MALEPRTSV ;
 label values MALEPRTS_2 MALEPRTS_2 ;
 label values SAMLIFENUM SAMLIFENUM ;
 label values MALPRT12_1 MALPRT12_1 ;
 label values MALPRT12V MALPRT12V ;
 label values MALPRT12_2 MALPRT12_2 ;
 label values SAMYEARNUM SAMYEARNUM ;
 label values SAMORAL12 SAMORAL12 ;
 label values RECEPANAL12 RECEPANAL12 ;
 label values INSERANAL12 INSERANAL12 ;
 label values SAMESEX1 SAMESEX1 ;
 label values MSAMEREL MSAMEREL ;
 label values MSMNONMON MSMNONMON ;
 label values MALSHT12 MALSHT12 ;
 label values JOHN2FRQ JOHN2FRQ ;
 label values PROS2FRQ PROS2FRQ ;
 label values HIVMAL12 HIVMAL12 ;
 label values MSMWEB12 MSMWEB12 ;
 label values MSMSORT12 MSMSORT12 ;
 label values CNDLSMAL CNDLSMAL ;
 label values CONDALLS CONDALLS ;
 label values MFLASTP MFLASTP ;
 label values WHYCOND WHYCOND ;
 label values ATTRACT ATTRACT ;
 label values ORIENT_A ORIENT_A ;
 label values ORIENT_B ORIENT_B ;
 label values CONFCONC CONFCONC ;
 label values TIMALON TIMALON ;
 label values RISKCHEK1 RISKCHEK1 ;
 label values RISKCHEK2 RISKCHEK2 ;
 label values RISKCHEK3 RISKCHEK3 ;
 label values RISKCHEK4 RISKCHEK4 ;
 label values RECTDOUCH RECTDOUCH ;
 label values STDTST12 STDTST12 ;
 label values STDSITE12 STDSITE12 ;
 label values STDTRT12 STDTRT12 ;
 label values GON GON ;
 label values CHLAM CHLAM ;
 label values HERPES HERPES ;
 label values GENWARTS GENWARTS ;
 label values SYPHILIS SYPHILIS ;
 label values EVRINJECT EVRINJECT ;
 label values EVRSHARE EVRSHARE ;
 label values EARNTYPE EARNTYPE ;
 label values EARN EARN ;
 label values EARNDK1 EARNDK1 ;
 label values EARNDK2 EARNDK2 ;
 label values EARNDK3 EARNDK3 ;
 label values EARNDK4 EARNDK4 ;
 label values TOINCWMY TOINCWMY ;
 label values TOTINC TOTINC ;
 label values FMINCDK1 FMINCDK1 ;
 label values FMINCDK2 FMINCDK2 ;
 label values FMINCDK3 FMINCDK3 ;
 label values FMINCDK4 FMINCDK4 ;
 label values FMINCDK5 FMINCDK5 ;
 label values PUBASST PUBASST ;
 label values PUBASTYP1 PUBASTYP1 ;
 label values FOODSTMP FOODSTMP ;
 label values WIC WIC ;
 label values HLPTRANS HLPTRANS ;
 label values HLPCHLDC HLPCHLDC ;
 label values HLPJOB HLPJOB ;
 label values FREEFOOD FREEFOOD ;
 label values HUNGRY HUNGRY ;
 label values MED_COST MED_COST ;
 label values AGER AGER ;
 label values FMARITAL FMARITAL ;
 label values RMARITAL RMARITAL ;
 label values EDUCAT EDUCAT ;
 label values HIEDUC HIEDUC ;
 label values HISPANIC HISPANIC ;
 label values RACE RACE ;
 label values HISPRACE HISPRACE ;
 label values HISPRACE2 HISPRACE2 ;
 label values NUMKDHH NUMKDHH ;
 label values NUMFMHH NUMFMHH ;
 label values HHFAMTYP HHFAMTYP ;
 label values HHPARTYP HHPARTYP ;
 label values NCHILDHH NCHILDHH ;
 label values HHKIDTYP HHKIDTYP ;
 label values CSPBBHH CSPBBHH ;
 label values CSPSBHH CSPSBHH ;
 label values CSPOKDHH CSPOKDHH ;
 label values INTCTFAM INTCTFAM ;
 label values PARAGE14 PARAGE14 ;
 label values EDUCMOM EDUCMOM ;
 label values AGEMOMB1 AGEMOMB1 ;
 label values FMARNO FMARNO ;
 label values AGER_I AGER_I ;
 label values FMARITAL_I FMARITAL_I ;
 label values RMARITAL_I RMARITAL_I ;
 label values EDUCAT_I EDUCAT_I ;
 label values HIEDUC_I HIEDUC_I ;
 label values HISPANIC_I HISPANIC_I ;
 label values RACE_I RACE_I ;
 label values HISPRACE_I HISPRACE_I ;
 label values HISPRACE2_I HISPRACE2_I ;
 label values NUMKDHH_I NUMKDHH_I ;
 label values NUMFMHH_I NUMFMHH_I ;
 label values HHFAMTYP_I HHFAMTYP_I ;
 label values HHPARTYP_I HHPARTYP_I ;
 label values NCHILDHH_I NCHILDHH_I ;
 label values HHKIDTYP_I HHKIDTYP_I ;
 label values CSPBBHH_I CSPBBHH_I ;
 label values CSPSBHH_I CSPSBHH_I ;
 label values CSPOKDHH_I CSPOKDHH_I ;
 label values INTCTFAM_I INTCTFAM_I ;
 label values PARAGE14_I PARAGE14_I ;
 label values EDUCMOM_I EDUCMOM_I ;
 label values AGEMOMB1_I AGEMOMB1_I ;
 label values FMARNO_I FMARNO_I ;
 label values HADSEX HADSEX ;
 label values SEXONCE SEXONCE ;
 label values VRY1STSX VRY1STSX ;
 label values FIRSTPFLAG FIRSTPFLAG ;
 label values ELAPSED ELAPSED ;
 label values SEXMAR SEXMAR ;
 label values SEXUNION SEXUNION ;
 label values FSEXRLTN FSEXRLTN ;
 label values SEX1MTHD1 SEX1MTHD1 ;
 label values SEX1MTHD2 SEX1MTHD2 ;
 label values SEX1MTHD3 SEX1MTHD3 ;
 label values SEX1MTHD4 SEX1MTHD4 ;
 label values LSEXDATE LSEXDATE ;
 label values SEX3MO SEX3MO ;
 label values SEX12MO SEX12MO ;
 label values LSEXPRAC LSEXPRAC ;
 label values LSEXRLTN LSEXRLTN ;
 label values LSEXUSE1 LSEXUSE1 ;
 label values LSEXUSE2 LSEXUSE2 ;
 label values LSEXUSE3 LSEXUSE3 ;
 label values LSEXUSE4 LSEXUSE4 ;
 label values METH12M1 METH12M1 ;
 label values METH12M2 METH12M2 ;
 label values METH12M3 METH12M3 ;
 label values METH12M4 METH12M4 ;
 label values METH3M1 METH3M1 ;
 label values METH3M2 METH3M2 ;
 label values METH3M3 METH3M3 ;
 label values METH3M4 METH3M4 ;
 label values NUMP3MOS NUMP3MOS ;
 label values LIFPRTNR LIFPRTNR ;
 label values PARTS1YR PARTS1YR ;
 label values PARTDUR1 PARTDUR1 ;
 label values PARTDUR2 PARTDUR2 ;
 label values PARTDUR3 PARTDUR3 ;
 label values COHEVER COHEVER ;
 label values EVMARCOH EVMARCOH ;
 label values PMARRNO PMARRNO ;
 label values NONMARR NONMARR ;
 label values TIMESCOH TIMESCOH ;
 label values MARDAT01 MARDAT01 ;
 label values MARDAT02 MARDAT02 ;
 label values MARDAT03 MARDAT03 ;
 label values MARDAT04 MARDAT04 ;
 label values MAREND01 MAREND01 ;
 label values MAREND02 MAREND02 ;
 label values MAREND03 MAREND03 ;
 label values MAREND04 MAREND04 ;
 label values MARDIS01 MARDIS01 ;
 label values MARDIS02 MARDIS02 ;
 label values MARDIS03 MARDIS03 ;
 label values MARDIS04 MARDIS04 ;
 label values MAR1DISS MAR1DISS ;
 label values PREMARW1 PREMARW1 ;
 label values COHAB1 COHAB1 ;
 label values COHSTAT COHSTAT ;
 label values COHOUT COHOUT ;
 label values COH1DUR COH1DUR ;
 label values CSPBIOKD CSPBIOKD ;
 label values DATBABY1 DATBABY1 ;
 label values B1PREMAR B1PREMAR ;
 label values MARBABY1 MARBABY1 ;
 label values CEBOW CEBOW ;
 label values CEBOWC CEBOWC ;
 label values CEBOWP CEBOWP ;
 label values EVRNOPAT EVRNOPAT ;
 label values NONLIVEB NONLIVEB ;
 label values COMPREG COMPREG ;
 label values ABORTION ABORTION ;
 label values LOSSNUM LOSSNUM ;
 label values PARENT01 PARENT01 ;
 label values PARENT02 PARENT02 ;
 label values PARENT03 PARENT03 ;
 label values PARENT04 PARENT04 ;
 label values PARENT05 PARENT05 ;
 label values PARENT06 PARENT06 ;
 label values PARENT07 PARENT07 ;
 label values PARENT08 PARENT08 ;
 label values PARENT09 PARENT09 ;
 label values PARENT10 PARENT10 ;
 label values WANTB01 WANTB01 ;
 label values WANTB02 WANTB02 ;
 label values WANTB03 WANTB03 ;
 label values WANTB04 WANTB04 ;
 label values WANTB05 WANTB05 ;
 label values WANTB06 WANTB06 ;
 label values WANTB07 WANTB07 ;
 label values WANTB08 WANTB08 ;
 label values WANTB09 WANTB09 ;
 label values WANTB10 WANTB10 ;
 label values HADSEX_I HADSEX_I ;
 label values SEXONCE_I SEXONCE_I ;
 label values VRY1STSX_I VRY1STSX_I ;
 label values VRY1STAG_I VRY1STAG_I ;
 label values SEXMAR_I SEXMAR_I ;
 label values SEXUNION_I SEXUNION_I ;
 label values FSEXRLTN_I FSEXRLTN_I ;
 label values SEX1MTHD1_I SEX1MTHD1_I ;
 label values SEX1MTHD2_I SEX1MTHD2_I ;
 label values SEX1MTHD3_I SEX1MTHD3_I ;
 label values SEX1MTHD4_I SEX1MTHD4_I ;
 label values LSEXDATE_I LSEXDATE_I ;
 label values SEX3MO_I SEX3MO_I ;
 label values SEX12MO_I SEX12MO_I ;
 label values LSEXRAGE_I LSEXRAGE_I ;
 label values LSEXRLTN_I LSEXRLTN_I ;
 label values LSEXUSE1_I LSEXUSE1_I ;
 label values LSEXUSE2_I LSEXUSE2_I ;
 label values LSEXUSE3_I LSEXUSE3_I ;
 label values LSEXUSE4_I LSEXUSE4_I ;
 label values METH12M1_I METH12M1_I ;
 label values METH12M2_I METH12M2_I ;
 label values METH12M3_I METH12M3_I ;
 label values METH12M4_I METH12M4_I ;
 label values METH3M1_I METH3M1_I ;
 label values METH3M2_I METH3M2_I ;
 label values METH3M3_I METH3M3_I ;
 label values METH3M4_I METH3M4_I ;
 label values NUMP3MOS_I NUMP3MOS_I ;
 label values LIFPRTNR_I LIFPRTNR_I ;
 label values PARTS1YR_I PARTS1YR_I ;
 label values PARTDUR1_I PARTDUR1_I ;
 label values PARTDUR2_I PARTDUR2_I ;
 label values PARTDUR3_I PARTDUR3_I ;
 label values COHEVER_I COHEVER_I ;
 label values EVMARCOH_I EVMARCOH_I ;
 label values PMARRNO_I PMARRNO_I ;
 label values NONMARR_I NONMARR_I ;
 label values TIMESCOH_I TIMESCOH_I ;
 label values MARDAT01_I MARDAT01_I ;
 label values MARDAT02_I MARDAT02_I ;
 label values MARDAT03_I MARDAT03_I ;
 label values MARDAT04_I MARDAT04_I ;
 label values MAREND01_I MAREND01_I ;
 label values MAREND02_I MAREND02_I ;
 label values MAREND03_I MAREND03_I ;
 label values MAREND04_I MAREND04_I ;
 label values MARDIS01_I MARDIS01_I ;
 label values MARDIS02_I MARDIS02_I ;
 label values MARDIS03_I MARDIS03_I ;
 label values MARDIS04_I MARDIS04_I ;
 label values MAR1DISS_I MAR1DISS_I ;
 label values PREMARW1_I PREMARW1_I ;
 label values COHAB1_I COHAB1_I ;
 label values COHSTAT_I COHSTAT_I ;
 label values COHOUT_I COHOUT_I ;
 label values COH1DUR_I COH1DUR_I ;
 label values CSPBIOKD_I CSPBIOKD_I ;
 label values DATBABY1_I DATBABY1_I ;
 label values AGEBABY1_I AGEBABY1_I ;
 label values B1PREMAR_I B1PREMAR_I ;
 label values MARBABY1_I MARBABY1_I ;
 label values CEBOW_I CEBOW_I ;
 label values CEBOWC_I CEBOWC_I ;
 label values CEBOWP_I CEBOWP_I ;
 label values EVRNOPAT_I EVRNOPAT_I ;
 label values NONLIVEB_I NONLIVEB_I ;
 label values COMPREG_I COMPREG_I ;
 label values ABORTION_I ABORTION_I ;
 label values LOSSNUM_I LOSSNUM_I ;
 label values PARENT01_I PARENT01_I ;
 label values PARENT02_I PARENT02_I ;
 label values PARENT03_I PARENT03_I ;
 label values PARENT04_I PARENT04_I ;
 label values PARENT05_I PARENT05_I ;
 label values PARENT06_I PARENT06_I ;
 label values PARENT07_I PARENT07_I ;
 label values PARENT08_I PARENT08_I ;
 label values PARENT09_I PARENT09_I ;
 label values PARENT10_I PARENT10_I ;
 label values WANTB01_I WANTB01_I ;
 label values WANTB02_I WANTB02_I ;
 label values WANTB03_I WANTB03_I ;
 label values WANTB04_I WANTB04_I ;
 label values WANTB05_I WANTB05_I ;
 label values WANTB06_I WANTB06_I ;
 label values WANTB07_I WANTB07_I ;
 label values WANTB08_I WANTB08_I ;
 label values WANTB09_I WANTB09_I ;
 label values WANTB10_I WANTB10_I ;
 label values DADTYPE DADTYPE ;
 label values DADTYPU5 DADTYPU5 ;
 label values DADTYP518 DADTYP518 ;
 label values NUMCRU18 NUMCRU18 ;
 label values NUMNCU18 NUMNCU18 ;
 label values SUPP12MO SUPP12MO ;
 label values DADTYPE_I DADTYPE_I ;
 label values DADTYPU5_I DADTYPU5_I ;
 label values DADTYP518_I DADTYP518_I ;
 label values NUMCRU18_I NUMCRU18_I ;
 label values NUMNCU18_I NUMNCU18_I ;
 label values SUPP12MO_I SUPP12MO_I ;
 label values INTENT INTENT ;
 label values ADDEXP ADDEXP ;
 label values INTENT_I INTENT_I ;
 label values ADDEXP_I ADDEXP_I ;
 label values CURR_INS CURR_INS ;
 label values INFEVER INFEVER ;
 label values EVHIVTST EVHIVTST ;
 label values CURR_INS_I CURR_INS_I ;
 label values INFEVER_I INFEVER_I ;
 label values EVHIVTST_I EVHIVTST_I ;
 label values METRO METRO ;
 label values RELIGION RELIGION ;
 label values LABORFOR LABORFOR ;
 label values METRO_I METRO_I ;
 label values RELIGION_I RELIGION_I ;
 label values LABORFOR_I LABORFOR_I ;
 label values POVERTY POVERTY ;
 label values TOTINCR TOTINCR ;
 label values PUBASSIS PUBASSIS ;
 label values POVERTY_I POVERTY_I ;
 label values TOTINCR_I TOTINCR_I ;
 label values PUBASSIS_I PUBASSIS_I ;
 label values CMINTVW CMINTVW ;
 label values CMLSTYR CMLSTYR ;
 label values CMFIVYR CMFIVYR ;

#delimit cr

/********************************************************************

 Section 4: Save Outfile

  This section saves out a Stata system format file.  There is no reason to
  modify it if the macros in Section 1 were specified correctly.

*********************************************************************/

save `outfile', replace

