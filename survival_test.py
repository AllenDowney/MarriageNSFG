"""This file contains code for use with "Think Stats",
by Allen B. Downey, available from greenteapress.com

Copyright 2014 Allen B. Downey
License: GNU GPLv3 http://www.gnu.org/licenses/gpl.html
"""

from __future__ import print_function, division

import unittest
import survival

import thinkstats2
import thinkplot


class Test(unittest.TestCase):

    def testMakeSurvival(self):
        complete = [1, 2, 3, 4, 5]
        sf = survival.MakeSurvivalFromSeq(complete)
        self.assertAlmostEqual(sf[1], 0.8)
        hf = sf.MakeHazardFunction()
        ts, lams = hf.Render()
        self.assertAlmostEqual(hf[2], 0.25)

    def testSurvival(self):
        complete = [1, 2, 3, 4, 5]
        ongoing = [3, 4, 5]
        hf = survival.EstimateHazardFunction(complete, ongoing)
        self.assertAlmostEqual(hf[3], 1 / 6.0)
        self.assertAlmostEqual(hf[5], 0.5)

        sf = hf.MakeSurvival()
        self.assertAlmostEqual(sf[0], 1.0)
        self.assertAlmostEqual(sf[3], 0.625)
        self.assertAlmostEqual(sf[5], 0.234375)


if __name__ == "__main__":
    unittest.main()
