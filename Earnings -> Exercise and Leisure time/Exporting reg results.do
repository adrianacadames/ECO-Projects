/*
Project: Is personal income determinant, by causation, of how much free leisure and exercising time employed Americans of age 18 to 65 decide to allocate in their time budget?

IV AND OLS RESULTS
EXPORTING RESULTS FOR LATEX

Author: Adriana Adames
Date: 10/21/2025 - 12/10/2025
*/

***************************
*OLS Estimation
reg exleisure weeklyearned education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart, robust

***************************
*Simple IV to start (IV WITHOUT ANY OTHER CONTROL/CONFOUNDING VARIABLES):

*Structural equation
reg exleisure weeklyearned
*First stage equation
//1.Regress weeklyearned and education to test the condition that the instrument is correlated to the independent variable
reg weeklyearned education
//Significant correlation
*Reduced-form equation
reg exleisure education
*IV estimate = coefficient of education in reduced-form equation/coefficient of education in first stage equation or found using:
*STATA IV command
ivregress 2sls exleisure (weeklyearned = education), robust

***************************
//Next
***************************
*1) Full 2SLS Stage Regressions
*2) Create etable with OLS, simple IV, IV with added vars, full IV
//For Male vs female section:
*3) Create etable with Interaction IV, male IV, female IV

clear all
set more off
use ATUScleaned.dta, clear

**************
*1) 2SLS Stages
//First stage equation
reg weeklyearned education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart, robust
estimates store fst
//Reduced form equation
reg exleisure education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year fullpart, robust
estimates store rfeq
//2sls
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education), robust
estimates store twosls

***Code from youtube video to export table 3: https://www.youtube.com/watch?time_continue=174&v=fyrGUm_fx5k&embeds_referring_euri=https%3A%2F%2Fwww.google.com%2Fsearch%3Fq%3Dhow%2Bto%2Bexport%2Bfirst%2Band%2Bsecond%2Bstage%2Biv%2Bregress%2Bstata%2Btables%2Bin%2Bpanel%26rlz%3D1C1RXQR_enUS1072US1072&source_ve_path=MjM4NTE
est clear

eststo stage1: reg weeklyearned education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart, robust
estadd scalar f round(e(F), 0.001)

eststo rfeq2: reg exleisure education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year fullpart, robust

eststo res2: ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year i.fullpart (weeklyearned = education), robust
estat firststage
estadd scalar f r(singleresults)[1,4]

#delimit ;
esttab stage1 rfeq2 res2 using "2sls Results 1.tex",
replace
label
se(3)
b(4)
keep(weeklyearned education)
title("IV 2SLS regression results"\label{columns})
mtitles("First Stage" "Reduced Form" "2SLS")
scalars("r2 R-Squared" "f F-test" "N Observations")
addnote("Regression results for full IV First Stage, Reduced Form Equation, and IV Results. All covariates are included in the regressions but not displayed (see Appendix for complete tables).")
;



*****************
*2) Etable with OLS, simple IV, IV with added vars, full IV
//OLS
reg exleisure weeklyearned education age i.male hh_numownkids i.married education i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.fullpart i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer i.statefip i.year, robust
estimate store mols
eststo t0
estat ovtest
estat vif
// Simple IV
ivregress 2sls exleisure (weeklyearned = education), robust
estimates store m1
eststo t1
estat endogenous
//IV With demographic vars (Without health and time vars)
ivregress 2sls exleisure age i.male hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.fullpart i.year i.statefip (weeklyearned = education), robust
estimates store m2
eststo t2
estat endogenous
//IV With demographic and health variables (Without time vars)
ivregress 2sls exleisure age i.male hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.fullpart i.genh1 i.genh2 i.genh3 i.genh4 i.year i.statefip (weeklyearned = education), robust
estimates store m3
eststo t3
estat endogenous
//Full IV reg (time vars are added)
ivregress 2sls exleisure age i.male hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.fullpart i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer i.year i.statefip (weeklyearned = education), robust
estimates store m4
eststo t4
estat endogenous
**Etable with the models (USED+Fixed a little in LaTex)
graph set window fontface "Times New Roman"
etable, estimates(mols m1 m2 m3 m4) stars(0.01 "***".05 "**" .01 "*", attach(_r_b)) export(Exleisure IV Etable 2.tex, replace) keep(exleisure weeklyearned education age i.male hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.fullpart i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer) note("Regression results for simple IV to added variables for the complete results. All covariates are included in the regressions, but year and state are not displayed (see Appendix for complete tables).") mstat(r2, label(R-Squared) nformat(%9.0g)) mstat(r2_a, label(Adjusted R-Squared) nformat(%9.0g)) mstat(aic, nformat( %9.0g)) mstat(bic, nformat(%9.0g)) 

//statefip are not included in the presentation (yes in the regression) because they make the table very long and few are sig
//Can also be done with:
esttab t0 t1 t2 t3 t4 using "Etable2.tex", title(Regression results) replace keep(weeklyearned education age 1.male hh_numownkids 1.married 1.army 1.difficulties 1.hispanic 1.white 1.black 1.asian1 1.hawaiipac 1.fullpart 1.genh1 1.genh2 1.genh3 1.genh4 religion worknstudy volunteer) mstat(N, nformat(%9.0g)) mstat(r2, label(R-Squared) nformat(%9.0g)) mstat(r2_a, label(Adjusted R-Squared) nformat(%9.0g)) mstat(aic, nformat( %9.0g)) mstat(bic, nformat(%9.0g)) addnote("Regression results for simple IV to added variables for the complete results. All covariates are included in the regressions, but year and state are not displayed (see Appendix for complete tables).")


*********************
*3) Etable with Interaction IV, male IV, female IV
//Add interaction vars
ivregress 2sls exleisure age i.male hh_numownkids i.male#c.hh_numownkids i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.year i.fullpart i.married i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer i.statefip (weeklyearned = education), robust
estimates store m5
estat endogenous
//Male IV
ivregress 2sls exleisure age hh_numownkids i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.year i.fullpart i.married i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer i.statefip (weeklyearned = education) if male ==1, robust
////Male and i.male#c.hh_numownkids omitted because of multicollinearity
estimates store male
estat endogenous
//Female IV
ivregress 2sls exleisure age hh_numownkids i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.year i.fullpart i.married i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer i.statefip (weeklyearned = education) if male ==0, robust
////Male and i.male#c.hh_numownkids omitted because of multicollinearity
estimates store female
estat endogenous
////Male OLS
reg exleisure weeklyearned education age i.male hh_numownkids i.male#c.hh_numownkids i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.year i.fullpart i.married i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer i.statefip, robust
estimates store male2
estat vif
estat ovtest

**Etable with the models
graph set window fontface "Times New Roman"
etable, estimates(m5 male female male2) stars(0.01 "***".05 "**" .01 "*", attach(_r_b)) export(Exleisure IV Etable 3.tex, replace) keep(exleisure weeklyearned education age i.male hh_numownkids i.male#c.hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.fullpart i.genh1 i.genh2 i.genh3 i.genh4 religion worknstudy volunteer) note("Regression results for the IV 2SLS regression with the added interaction malexhh_numownkids (first column), IV 2SLS regression results uniquely for male respondents (second column), IV 2SLS regression results uniquely for female respondents (third column), and OLS results uniquely for male (fourth column). All covariates are included in the regressions, but year and state are not displayed (see Appendix for complete tables).") mstat(N, nformat(%9.0g)) mstat(r2, label(R-Squared) nformat(%9.0g)) mstat(r2_a, label(Adjusted R-Squared) nformat(%9.0g)) mstat(aic, nformat( %9.0g)) mstat(bic, nformat(%9.0g))