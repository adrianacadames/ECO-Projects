/*
Project: Is personal income determinant, by causation, of how much free leisure and exercising time employed Americans of age 18 to 65 decide to allocate in their time budget?

RUNNING REGRESSIONS BY GENDER

Author: Adriana Adames
Date: 10/21/2025 - 12/10/2025
*/

*STATA IV Command:
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education), robust
estimates store me1
//male
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education)  if male == 1, robust
estimates store me2
//female
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education)  if male == 0, robust
estimates store me3

etable, estimates(me1 me2 me3) stars(.05 "*" .01 "**", attach(_r_b))

*Let's do a chow test to see if separating the regressions make sense
//Pool model
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education), robust
estimates store pool
scalar rsspool = e(rss)
scalar dfpool = e(df_r)
scalar dfpoolm = e(df_m)
scalar N = 49601
//Model for men
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education)  if male == 1, robust
estimates store men
scalar rssmen = e(rss)
//Model for women
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education)  if male == 0, robust
estimates store women
scalar rsswo = e(rss)
//Calculate rss of the unrestricted model
scalar rssunr = rssmen + rsswo
//N in restricted model
count if male == 1 | male == 0
//Calculate K
scalar K = dfpoolm + 1
//Calculate the Fstat
scalar Ftest = ((rsspool-rssunr)/K)/(rssunr/(N-2*K))
//Show results
display "Number of parameters (k): " K
display "Total observations (N): " N
display "Pooled RSS: " rsspool
display "Separate RSS (sum): " rssunr
display "RSS reduction: " (rsspool - rssunr)
display _newline "Chow F-statistic: " Ftest
display "Numerator df: " K
display "Denominator df: " (N - 2*K)
display "P-value: " Ftail(K, N - 2*K, Ftest)
//We reject the null, meaning that the model is not fine on its own