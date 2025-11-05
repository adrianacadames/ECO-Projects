/* Adriana Adames
ECO350 H Project:  Is personal income determinant, by causation, of how much free leisure and exercising time employed
Americans of age 18 to 65 decide to allocate in their time budget?
10-21-2025
*/

*Preamble
clear all
set more off

*Change Working directory
cd "C:\Users\adria\Documents\ECO350 H Project\"

*Import data
use atus_adriana_update.dta, clear

*Initial observations of the data
edit
describe
// 154,030 obs
summarize

******************************************
*Data Cleanup*
******************************************

*First, restrict to wanted population:

**Make age restrictions
sum age
//Drop nonadults
drop if age < 18
//Will include obs based on if they are not part of the full social security age (using year and age)
///Using integers for some ages is an assumption I am taking
///Also, Not knowing if they were born in jan 1st is another assumption
/// Birth year <=1937 retirement age = 65
gen yearofbirth = year-age
drop if yearofbirth <= 1937 & age >= 65
/// Birth year 1938 retirement age = 65 years and 2 months (will use integer 65)
drop if yearofbirth == 1938 & age >= 65
/// Birth year 1939 retirement age = 65 years and 4 months (will use integer 65)
drop if yearofbirth == 1939 & age >= 65
/// Birth year 1940 retirement age = 65 years and 6 months (will use integer 66)
drop if yearofbirth == 1940 & age >= 66
/// Birth year 1941 retirement age = 65 years and 8 months (will use integer 66)
drop if yearofbirth == 1941 & age >= 66
/// Birth year 1942 retirement age = 65 years and 10 months (will use integer 66)
drop if yearofbirth == 1942 & age >= 66
/// Birth year 1943-1954 retirement age = 66
drop if yearofbirth > 1943 & yearofbirth < 1954 & age >= 66
/// Birth year 1955 retirement age = 66 years and 2 months (will use integer 66)
drop if yearofbirth == 1955 & age >= 66
/// Birth year 1956 retirement age = 66 years and 4 months (will use integer 66)
drop if yearofbirth == 1956 & age >= 66
/// Birth year 1957 retirement age = 66 years and 6 months (will use integer 67)
drop if yearofbirth == 1957 & age >= 67
/// Birth year 1958 retirement age = 66 years and 8 months (will use integer 67)
drop if yearofbirth == 1958 & age >= 67
/// Birth year 1959 retirement age = 66 years and 10 months (will use integer 67)
drop if yearofbirth == 1959 & age >= 67
/// Birth year >=1960 retirement age = 67 (will use integer 67)
drop if yearofbirth >= 1960 & age >= 67
//https://www.ssa.gov/benefits/retirement/planner/agereduction.html ; https://www.oregon.gov/pers/RET/Documents/SSA_age.pdf#:~:text=1937%20or%20earlier%2065%201938%2065%20and,10%20months%201960%20and%20later%2067%201.
sum age

**Restrict to only employed individuals (that are not absent)
drop if empstat == 2
drop if empstat == 3
drop if empstat == 4
drop if empstat == 5
drop if empstat == 99

**Restrict to individuals that are not full time students
drop if schlcoll == 3
drop if schlcoll == 5


*Second, clean main variables:

**Clean/create independent wage/earning variable

***Generate weekly earnings
gen weeklyearned = .
*1. Use earnweek variable
replace weeklyearned = earnweek if earnweek != 99999.99 & earnweek > 1
sum earnweek weeklyearned

count if earnweek == 99999.99

*2. Erase obs without weekly earnings or hourly wages
drop if earnweek == 99999.99 & hourwage == 999.99
drop if earnweek <= 1 & hourwage <= 1
drop if earnweek <= 1 & hourwage == 999.99
drop if earnweek == 99999.99 & hourwage <= 1
drop if earnweek <= 1 & uhrsworkt == 9995 & uhrswork1_cps8 == 999 & uhrsworkt_cps8 == 9999
drop if earnweek <= 1 & uhrsworkt == 9995 & uhrswork1_cps8 == 995 & uhrsworkt_cps8 == 9995

*3. Use hourly wages and hours usually worked per week for those with missing earnweek data
//First, take those obs that have the same ATUS and CPS interview information
replace weeklyearned = hourwage*uhrsworkt if earnweek == 99999.99 & uhrsworkt_cps8 == uhrsworkt
replace weeklyearned = hourwage*uhrsworkt if earnweek <= 1 & uhrsworkt_cps8 == uhrsworkt
replace weeklyearned = hourwage*uhrsworkt if earnweek <= 1 & uhrsworkt_cps8 == uhrsworkt
//Then, take those obs that do not have the CPS interview information and use the ATUS or viceversa
replace weeklyearned = hourwage*uhrsworkt if earnweek <= 1 & uhrsworkt_cps8 == 9999 & weeklyearned == . & uhrsworkt != 9995
replace weeklyearned = hourwage*uhrsworkt_cps8 if earnweek <= 1 & uhrsworkt == 9995 & weeklyearned == . & uhrsworkt_cps8 != 9995
//Lastly, for those obs with both the ATUS and the CPS hours and irrational earnweek data, use the ATUS (because ATUS was earlier than the CPS)
replace weeklyearned = hourwage*uhrsworkt if earnweek <= 1 & weeklyearned == . & uhrsworkt_cps8 != 9995 & uhrsworkt != 9995

*4. Erase those with weeklyearnings lower than the federal minimum wage (impossible or under the table money)
drop if weeklyearned <= 7.5

//Could also check and do this by min wage by state, but later maybe

count if missing(weeklyearned)
list if missing(weeklyearned)
//No missing obs
sum weeklyearned
//Total of 71,391 obs

**Create leasure and exercise time dependent variable
generate exleisure = act_carehh_modified + act_carenhh_modified + act_hhact_modified + act_pcare_modified + act_phone_modified + act_profserv_modified + act_purch_modified + act_social + act_sports + act_travel_socializing + act_travel_sport


*Third, clean other useful variables
*a) Form the male variable by changing sex variable
rename sex male
replace male = 0 if male == 2
label define male_lbl 1 "Male" 0 "Female" 99 "NIU", replace
label values male male_lbl

*b) Change the number of kids variable from qualitative to quantitative by removing label
label values hh_numownkids .

*c) Form the married variable
rename marst married
replace married = 1 if married == 1
replace married = 1 if married == 2
replace married = 0 if married == 3
replace married = 0 if married == 4
replace married = 0 if married == 5
replace married = 0 if married == 6
replace married = 99 if married == 99
label define married_lbl 1 "Married" 0 "Not married" 99 "NIU", replace
label values married married_lbl

*d) Create Genhealth variables
tabulate genhealth, generate(genh)
label define genh1_lbl 1 "Excellent Health" 0 "Not Excellent Health"
label define genh2_lbl 1 "Very Good Health" 0 "Not Very Good Health"
label define genh3_lbl 1 "Good Health" 0 "Not Good Health"
label define genh4_lbl 1 "Fair Health" 0 "Not Fair Health"
label values genh1 genh1_lbl
label values genh2 genh2_lbl
label values genh3 genh3_lbl
label values genh4 genh4_lbl

*e) Create Army person variable
generate army = .
replace army = 0 if vetstat == 2
replace army = 0 if afnow == 2
replace army = 1 if vetstat == 1
replace army = 1 if afnow == 1
label define army_lbl 1 "Served" 0 "Not Served"
label values army army_lbl

*f) Create education variable
generate education = .
replace education = 9 if educyrs == 109
replace education = 10 if educyrs == 110
replace education = 11 if educyrs == 111
replace education = 12 if educyrs == 112
replace education = 13 if educyrs == 213
replace education = 14 if educyrs == 214
replace education = 15 if educyrs == 215
replace education = 16 if educyrs == 216
replace education = 16 if educyrs == 217
***for less than a 1st grade / 1st through 4th
replace education = 0.5 if educyrs == 101
replace education = 2 if educyrs == 102
replace education = 5.5 if educyrs == 105
replace education = 7.5 if educyrs == 107
***for masters and doctorals
replace education = 17 if educyrs == 317
replace education = 18 if educyrs == 318
replace education = 19 if educyrs == 319
replace education = 18 if educyrs == 316
replace education = 20 if educyrs == 321
***a pro degree can de between 3 and 8 years so the mean is 5.5 
replace education = 21.5 if educyrs == 320

*g) Create Difficulties variable
generate difficulties = .
replace difficulties = 0 if diffmob == 1 & diffphys == 1 & diffrem == 1
replace difficulties = 1 if diffmob == 2
replace difficulties = 1 if diffphys == 2
replace difficulties = 1 if diffrem == 2
label define difficulties_lbl 1 "Has difficulties" 0 "Does not have difficulties"
label values difficulties difficulties_lbl

*h) Create religion time variable
generate religion = act_relig + act_travel_religion

*i) Create work related time
generate worknstudy = act_educ_modified + act_travel_education + act_travel_work + act_work

*j) Create volunteering time
generate volunteer = act_travel_volunteering + act_vol

*k) Create hispanic variable
generate hispanic = .
replace hispanic = 1 if hispan == 210
replace hispanic = 1 if hispan == 211
replace hispanic = 1 if hispan == 212
replace hispanic = 1 if hispan == 213
replace hispanic = 1 if hispan == 220
replace hispanic = 1 if hispan == 230
replace hispanic = 1 if hispan == 240
replace hispanic = 1 if hispan == 241
replace hispanic = 1 if hispan == 242
replace hispanic = 1 if hispan == 243
replace hispanic = 1 if hispan == 244
replace hispanic = 1 if hispan == 250
replace hispanic = 0 if hispan == 100
label define hispanic_lbl 1 "Hispanic" 0 "Not Hispanic"
label values hispanic hispanic_lbl

*l) Create white variable
generate white = .
replace white = 1 if race == 100
replace white = 0 if race != 100
label define white_lbl 1 "White" 0 "Not White"
label values white white_lbl

*m) Create Black variable
generate black = .
replace black = 1 if race == 110
replace black = 0 if race != 110
label define black_lbl 1 "Black" 0 "Not Black"
label values black black_lbl

*n) Create asian variable
generate asian1 = .
replace asian1 = 1 if race == 131
replace asian1 = 0 if race != 131
label define asian1_lbl 1 "Asian" 0 "Not Asian"
label values asian1 asian1_lbl

*o) Create hawaiipac variable
generate hawaiipac = .
replace hawaiipac = 1 if race == 132
replace hawaiipac = 0 if race != 132
label define hawaiipac_lbl 1 "Hawaiian Pacific Islander" 0 "Not Hawaiian Pacific Islander"
label values hawaiipac hawaiipac_lbl



*Sum and describe final data from variables to use
describe exleisure weeklyearned age male hh_numownkids married genh1 genh2 genh3 genh4 bmi education army difficulties religion worknstudy volunteer hispanic white black asian1 hawaiipac
sum exleisure weeklyearned age male hh_numownkids married genh1 genh2 genh3 genh4 bmi education army difficulties religion worknstudy volunteer hispanic white black asian1 hawaiipac
****Sum tells me low info on BMI, drop it
drop bmi
****Also, drop observations without genhealth info
drop if genhealth == .
**new sum:
sum exleisure weeklyearned age male hh_numownkids married genh1 genh2 genh3 genh4 education army difficulties religion worknstudy volunteer hispanic white black asian1 hawaiipac statefip
// 50,591 obs


***************************
*Observe data and Look for IV*
***************************
pwcorr exleisure weeklyearned age male hh_numownkids married genh1 genh2 genh3 genh4 education army difficulties religion worknstudy volunteer hispanic white black asian1 hawaiipac statefip

reg weeklyearned education age
// Normal labor information

*Observe if Mincer Model holds
gen lnw = ln(weeklyearned)
gen age2 = age^2
reg lnw education age age2
// It does hold!

//Let's see it:
predict y_hat, xb
sort age
twoway (scatter lnw age) (line y_hat age, sort)
twoway (scatter lnw age) (qfit lnw age)

reg weeklyearned age age2
predict y_hat1, xb
sort age
twoway (scatter weeklyearned age) (line y_hat1 age, sort)
twoway (scatter weeklyearned age) (qfit weeklyearned age)
twoway (qfit weeklyearned age)

//What about this same model but instead of wages we add the dependent var of the study?
reg exleisure education age age2
////Same graph but opposite concavity

//Let's see it:
predict y_hat2, xb
sort age
twoway (scatter exleisure age) (line y_hat2 age, sort)
twoway (scatter exleisure age) (qfit exleisure age)
twoway (qfit exleisure age)


 reg exleisure education age age2 if male == 1
  reg exleisure education age age2 if male == 0
////Significance of education on leisure time exists for females but not males

///What if we add our weekly earnings?
reg exleisure weeklyearned education age age2
//Education becomes insignificant

///What if we add the number of kids?
reg exleisure weeklyearned education age age2 hh_numownkids if male == 1
reg exleisure weeklyearned education age age2 hh_numownkids if male == 0
//Adding number of children to care for makes the exleisure-age derivative smaller for women compared to men. 

reg exleisure weeklyearned education age age2 hh_numownkids
// Let's see it
predict y_hat3, xb
sort age
twoway (scatter exleisure age) (line y_hat3 age, sort)
twoway (scatter exleisure age) (qfit exleisure age)
twoway (qfit exleisure age)


reg exleisure weeklyearned education age age2 hh_numownkids if male == 1
// Let's see it
predict y_hat4, xb
sort age
twoway (scatter exleisure age) (line y_hat4 age, sort)
twoway (scatter exleisure age) (qfit exleisure age)
twoway (qfit exleisure age)
twoway (qfit y_hat4 age)


reg exleisure weeklyearned education age age2 hh_numownkids if male == 0
// Let's see it
predict y_hat5, xb
sort age
twoway (scatter exleisure age) (line y_hat5 age, sort)
twoway (scatter exleisure age) (qfit exleisure age)
twoway (qfit exleisure age)
twoway (qfit y_hat5 age)

*Before conducting IV
reg exleisure education
// Education is correlated with exleisure (not causal)
reg exleisure weeklyearned education
//Education becomes insignificant as earnings are added, so these soak the information of the other.

***************************
**Conducting IV**
***************************
*IV WITHOUT ANY OTHER CONTROL/CONFOUNDING VARIABLES
*Structural equation
reg exleisure weeklyearned

*First stage equation
*1.Regress weeklyearned and education to test the condition that the instrument is correlated to the independent variable
reg weeklyearned education
//Significant correlation

*Reduced-form equation
reg exleisure education

*IV estimate = coefficient of education in reduced-form equation/coefficient of education in first stage equation
di -1.215042/109.0717

*STATA IV command
ivregress 2sls exleisure (weeklyearned = education), robust
estimates store m1

//ALMOST SAME ESTIMATE AS WITH EQUATIONS!

*IV ADDING CONTROL AND CONFOUNDING VARIABLES
*Structural equation:
reg exleisure weeklyearned age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year
*First Stage:
reg weeklyearned education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year
*Reduced-form equation:
reg exleisure education age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 education i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year
*IV estimate = coefficient of education in reduced-form equation/coefficient of education in first stage equation
di -.7704434/95.39874 
//= -.00807603

*STATA IV Command:
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year (weeklyearned = education), robust
///Coefficient = -0.008076
//ALMOST SAME ESTIMATE AS WITH EQUATIONS!
estimates store m2

*Observe the strength of the instrument and for endogeneity
estat firststage
estat endogenous


***************************
**Exporting results**
***************************
*Estimate a few other regressions to add to etable
**First without health and time vars
ivregress 2sls exleisure age i.male hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year (weeklyearned = education), robust
estimates store m3
**Then add the health vars
ivregress 2sls exleisure age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year (weeklyearned = education), robust
estimates store m4

**Etable with the models
etable, estimates(m1 m3 m4 m2) stars(.05 "*" .01 "**", attach(_r_b))

***************************
*Looking at Elasticities*
***************************
**Make the model Log-log
gen lnexleis = ln(exleisure)
gen lned = ln(education)

**Regressions
*Model 1
ivregress 2sls lnexleis (lnw = lned), robust
//z insignificant
regress lnexleis lnw, robust
//t significant; I AM CONFUSED, ask professor for meanings
*Model 2
ivregress 2sls lnexleis age i.male hh_numownkids i.married i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year (lnw = lned), robust
*Model 3
ivregress 2sls lnexleis age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year (lnw = lned), robust
*Model 4
ivregress 2sls lnexleis age i.male hh_numownkids i.married i.genh1 i.genh2 i.genh3 i.genh4 i.army i.difficulties religion worknstudy volunteer i.hispanic i.white i.black i.asian1 i.hawaiipac i.statefip i.year (lnw = lned), robust
