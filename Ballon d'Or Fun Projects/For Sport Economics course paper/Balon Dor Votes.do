/* Do File for Balon D'Or Votes - ECO481 Paper
Purpose:  Is the current Ballon d'Or voting system good? Why the current Borda count has to be an 
adjusted voting method for the Balon d'Or.
Adriana Adames
11/19/2025
*/

*Preamble
clear all
set more off

*Change CD
cd "C:\Users\adria\Documents\ECO481 Balon Dor"

************************************************************2025********************************************************************************************
*Import data
import excel "2025 Balon D'or Votes", clear firstrow

*Clean
rename B v1
rename C v2
rename D v3
rename E v4
rename F v5
rename G v6
rename H v7
rename I v8
rename J v9
rename K v10
rename VotingScale country
//Error in vote 5
gen cv5 = .
replace cv5 = 1 if v5 == "Dembele"
replace cv5 = 2 if v5 == "Donnarumma"
replace cv5 = 3 if v5 == "Bellingham" 
replace cv5 = 4 if v5 == "D. Doue"
replace cv5 = 5 if v5 == "Dumfries"
replace cv5 = 6 if v5 == "Guirassy" 
replace cv5 = 7 if v5 == "Haaland" 
replace cv5 = 8 if v5 == "Gyokeres" 
replace cv5 = 9 if v5 == "Hakimi" 
replace cv5 = 10 if v5 == "Kane" 
replace cv5 = 11 if v5 == "Kvaratskhelia" 
replace cv5 = 12 if v5 == "Lewandowski" 
replace cv5 = 13 if v5 == "Mac Allister" 
replace cv5 = 14 if v5 == "L. Martinez" 
replace cv5 = 15 if v5 == "McTominay" 
replace cv5 = 16 if v5 == "Mbappe" 
replace cv5 = 17 if v5 == "Nuno Mendes" 
replace cv5 = 18 if v5 == "Joao Neves" 
replace cv5 = 19 if v5 == "Pedri" 
replace cv5 = 20 if v5 == "Palmer" 
replace cv5 = 21 if v5 == "Olise" 
replace cv5 = 22 if v5 == "Raphinha" 
replace cv5 = 23 if v5 == "Rice" 
replace cv5 = 24 if v5 == "Fabian Ruiz" 
replace cv5 = 25 if v5 == "Lamine Yamal" 
replace cv5 = 26 if v5 == "Wirtz" 
replace cv5 = 27 if v5 == "Vitinha" 
replace cv5 = 28 if v5 == "Vinicius Jr." 
replace cv5 = 29 if v5 == "Van Dijk" 
replace cv5 = 30 if v5 == "Salah" 
replace v5 = "Raphinha" if v5 == "Raphina"
//Error in vote 7
gen cv7 = .
replace cv7 = 1 if v7 == "Dembele"
replace cv7 = 2 if v7 == "Donnarumma"
replace cv7 = 3 if v7 == "Bellingham" 
replace cv7 = 4 if v7 == "D. Doue"
replace cv7 = 5 if v7 == "Dumfries"
replace cv7 = 6 if v7 == "Guirassy" 
replace cv7 = 7 if v7 == "Haaland" 
replace cv7 = 8 if v7 == "Gyokeres" 
replace cv7 = 9 if v7 == "Hakimi" 
replace cv7 = 10 if v7 == "Kane" 
replace cv7 = 11 if v7 == "Kvaratskhelia" 
replace cv7 = 12 if v7 == "Lewandowski" 
replace cv7 = 13 if v7 == "Mac Allister" 
replace cv7 = 14 if v7 == "L. Martinez" 
replace cv7 = 15 if v7 == "McTominay" 
replace cv7 = 16 if v7 == "Mbappe" 
replace cv7 = 17 if v7 == "Nuno Mendes" 
replace cv7 = 18 if v7 == "Joao Neves" 
replace cv7 = 19 if v7 == "Pedri" 
replace cv7 = 20 if v7 == "Palmer" 
replace cv7 = 21 if v7 == "Olise" 
replace cv7 = 22 if v7 == "Raphinha" 
replace cv7 = 23 if v7 == "Rice" 
replace cv7 = 24 if v7 == "Fabian Ruiz" 
replace cv7 = 25 if v7 == "Lamine Yamal" 
replace cv7 = 26 if v7 == "Wirtz" 
replace cv7 = 27 if v7 == "Vitinha" 
replace cv7 = 28 if v7 == "Vinicius Jr." 
replace cv7 = 29 if v7 == "Van Dijk" 
replace cv7 = 30 if v7 == "Salah" 
//Error in vote 8
gen cv8 = .
replace cv8 = 1 if v8 == "Dembele"
replace cv8 = 2 if v8 == "Donnarumma"
replace cv8 = 3 if v8 == "Bellingham" 
replace cv8 = 4 if v8 == "D. Doue"
replace cv8 = 5 if v8 == "Dumfries"
replace cv8 = 6 if v8 == "Guirassy" 
replace cv8 = 7 if v8 == "Haaland" 
replace cv8 = 8 if v8 == "Gyokeres" 
replace cv8 = 9 if v8 == "Hakimi" 
replace cv8 = 10 if v8 == "Kane" 
replace cv8 = 11 if v8 == "Kvaratskhelia" 
replace cv8 = 12 if v8 == "Lewandowski" 
replace cv8 = 13 if v8 == "Mac Allister" 
replace cv8 = 14 if v8 == "L. Martinez" 
replace cv8 = 15 if v8 == "McTominay" 
replace cv8 = 16 if v8 == "Mbappe" 
replace cv8 = 17 if v8 == "Nuno Mendes" 
replace cv8 = 18 if v8 == "Joao Neves" 
replace cv8 = 19 if v8 == "Pedri" 
replace cv8 = 20 if v8 == "Palmer" 
replace cv8 = 21 if v8 == "Olise" 
replace cv8 = 22 if v8 == "Raphinha" 
replace cv8 = 23 if v8 == "Rice" 
replace cv8 = 24 if v8 == "Fabian Ruiz" 
replace cv8 = 25 if v8 == "Lamine Yamal" 
replace cv8 = 26 if v8 == "Wirtz" 
replace cv8 = 27 if v8 == "Vitinha" 
replace cv8 = 28 if v8 == "Vinicius Jr." 
replace cv8 = 29 if v8 == "Van Dijk" 
replace cv8 = 30 if v8 == "Salah" 
replace v8 = "D. Doue" if v8 == "D.  Doue"
drop if cv8 == .
drop cv5 cv7 cv8

*Plurality
tab v1
// Dembele Wins with 73/100 votes

*Runoff voting
tab v1
// Dembele wins in first round with 73% of votes as the prefered candidate

*Instant-runoff voting IRV
//Dembele wins with majority in first choices

*Coombs Method
tab v10
//Least liked = Palmer who is eliminated





///Seems like Dembele has a big majority, so let's try another year, a controversial one, 2019

************************************************************2019********************************************************************************************
*Import data
import excel "2019 Balon D'or Votes", clear firstrow

*Clean
rename B v1
rename C v2
rename D v3
rename E v4
rename F v5

//Check if all variables have 176 votes
tab v1
***Yes
tab v2
***Yes
tab v3
***Yes
tab v4
***Yes
tab v5
***Yes

replace v4 = "Lewandowski" if v5 == "Lewadowski"
replace v5 = "Lewandowski" if v5 == "Lewadowski"
*No more typing issues here

***Check different types of voting

******
*Plurality
tab v1
// Van Dijk wins with 69/176 votes (39.2%)

******
*Runoff voting
tab v1
//No one reaches election threshold, so secondary ballot between top candidates Van Dijk vs Messi
//So 69/176 voted for Van Dijk as top choice and 61/176 for Messi
tab v2 if v1 != "Van Dijk" & v1 != "Messi"
// From those that did not vote for Messi or Van Dijk in the first vote (who are only 46 people) 13/46 voted for Van Dijk as second choice and 17/46 for Messi
di 69+13
di 61+17
di 82+78
// So Van Dijk gets 82/176 and Messi gets 78/176, which is still not the entire sample. Let's see who did not vote for them in either first or second round
count if v1 != "Van Dijk" & v1 != "Messi" & v2 != "Van Dijk" & v2 != "Messi"
//16 people
tab v3 if v1 != "Van Dijk" & v1 != "Messi" & v2 != "Van Dijk" & v2 != "Messi"
//In the 3rd vote Van Dijk gets 3/16 and Messi 4/16. Making it 85/176 for Van Dijk and 82/176 for Messi
tab v4 if v1 != "Van Dijk" & v1 != "Messi" & v2 != "Van Dijk" & v2 != "Messi" & v3 != "Van Dijk" & v3 != "Messi"
//In the 4th vote Van Dijk gets 2/9 and Messi 4/9. Making it 87/176 for Van Dijk and 86/176 for Messi
tab v5 if v1 != "Van Dijk" & v1 != "Messi" & v2 != "Van Dijk" & v2 != "Messi" & v3 != "Van Dijk" & v3 != "Messi" & v4 != "Van Dijk" & v4 != "Messi"
//In the 5th and last vote rankings, Van Dijk gets 1/3 and Messi 0/3. Making it 88/176 for Van Dijk and 86/176 for Messi
di 88+86
//3 people did not include Messi or Van Dijk in any of their top 5 votes
list if v1 != "Van Dijk" & v1 != "Messi" & v2 != "Van Dijk" & v2 != "Messi" & v3 != "Van Dijk" & v3 != "Messi" & v4 != "Van Dijk" & v4 != "Messi"
//These were United Emirates, Sri Lanka, and Slovenie
di 88/176
//Van Dijk wins with .5 of the votes against Messi's .4886

******
*Bucklin
//First round no one wins with majority
tab v1
//% in 1st choice: Van Dijk 39.2% (69/176), Messi 34.66% (61/176), Ronaldo 9.66%, Mane 9.66%, Salah 2.84%...
//Now, second choices are added to the first ones. 
list Country v1 v2
tab v2
//% in 2nd choice: Van Dijk 22.16% (39/176), Messi 27.27% (48), Ronaldo 21.59%, Mane 14.77%, Salah 2.84%...
/*Van Dijk = 61.36%
Messi = 61.93%
Ronaldo = 31.25%
Mane = 24.42
Salah = 5.68
*/
tab v2
//1. First round no one wins with majority. 
//2. Second choices are added to the first ones. 
//3. Messi wins through majority 

******
*Coombs Method

//1.Just keep 5 players most voted (as there are only 5 rounds)
replace v1 = "" if v1 != "Messi" & v1 != "Van Dijk" & v1 != "Mane" & v1 != "Salah" & v1 != "Ronaldo"
replace v2 = "" if v2 != "Messi" & v2 != "Van Dijk" & v2 != "Mane" & v2 != "Salah" & v2 != "Ronaldo"
replace v3 = "" if v3 != "Messi" & v3 != "Van Dijk" & v3 != "Mane" & v3 != "Salah" & v3 != "Ronaldo"
replace v4 = "" if v4 != "Messi" & v4 != "Van Dijk" & v4 != "Mane" & v4 != "Salah" & v4 != "Ronaldo"
replace v5 = "" if v5 != "Messi" & v5 != "Van Dijk" & v5 != "Mane" & v5 != "Salah" & v5 != "Ronaldo"

//Replace empty spots with the order in which they would have voted with the 5 players
replace v1 = v2 if v1 == ""
replace v2 = "" if v1 == v2
replace v2 = v3 if v2 == ""
replace v3 = "" if v2 == v3
replace v3 = v4 if v3 == ""
replace v4 = "" if v3 == v4
replace v4 = v5 if v4 == ""
replace v5 = "" if v4 == v5
replace v2 = v3 if v2 == ""
replace v3 = "" if v2 == v3
replace v3 = v4 if v3 == ""
replace v4 = "" if v3 == v4
replace v4 = v5 if v4 == ""
replace v5 = "" if v4 == v5

//Now there is a list without empty spots unless the country voted for other players that are not in the top 5
//Coombs method step 1, check for majority:
tab v1
//No Majority
//Step 2, eliminate the least liked in the final round
tab v5
//Ronaldo is the least liked, eliminate from the entire process and move votes up where Ronaldo was voted above round 5. This will result in a dataset with 4 rounds instead of 5.
replace v5 = "" if v5 == "Ronaldo"
replace v4 = "" if v4 == "Ronaldo"
replace v3 = "" if v3 == "Ronaldo"
replace v2 = "" if v2 == "Ronaldo"
replace v1 = "" if v1 == "Ronaldo"

replace v1 = v2 if v1 == ""
replace v2 = "" if v1 == v2
replace v2 = v3 if v2 == ""
replace v3 = "" if v2 == v3
replace v3 = v4 if v3 == ""
replace v4 = "" if v3 == v4
replace v4 = v5 if v4 == ""
replace v5 = "" if v4 == v5
drop v5

//Same process but in v4 now
tab v4
//Salah is the one with more votes in round 4
replace v4 = "" if v4 == "Salah"
replace v3 = "" if v3 == "Salah"
replace v2 = "" if v2 == "Salah"
replace v1 = "" if v1 == "Salah"
replace v1 = v2 if v1 == ""
replace v2 = "" if v1 == v2
replace v2 = v3 if v2 == ""
replace v3 = "" if v2 == v3
replace v3 = v4 if v3 == ""
replace v4 = "" if v3 == v4
drop v4

//Same process but in v3 now
tab v3
//Mane is the one with more votes in round 3
replace v3 = "" if v3 == "Mane"
replace v2 = "" if v2 == "Mane"
replace v1 = "" if v1 == "Mane"
replace v1 = v2 if v1 == ""
replace v2 = "" if v1 == v2
replace v2 = v3 if v2 == ""
replace v3 = "" if v2 == v3
drop v3


tab v1 // Van Dijk wins with majority now but continue

//Same process but in v2 now
tab v2
//Messi is the one with more votes in round 2
replace v2 = "" if v2 == "Messi"
replace v1 = "" if v1 == "Messi"
replace v1 = v2 if v1 == ""
replace v2 = "" if v1 == v2
//Van Dijk wins

////THIS SHOWS THAT WHOEVER WINS THE BALLON D'OR IS THE WINNER OF THE CERTAIN SYSTEM USED. NOT NECESSARILY THE BEST PLAYER IN THE WORLD.


************************************************************2024********************************************************************************************
*Import data
import excel "2024 Balon D'or Votes", clear firstrow

*Clean
rename B v1
rename C v2
rename D v3
rename E v4
rename F v5
rename G v6
rename H v7
rename I v8
rename J v9
rename K v10

//Check if all variables have 99 votes
tab v1
***Yes
tab v2
***Yes
tab v3
***Yes
tab v4
***Yes
tab v5
***Yes
tab v6
***Yes
tab v7
***Yes
tab v8
***Yes
tab v9
***Yes
tab v10
***Yes

*No typing issues here

***Check different types of voting
*Plurality
tab v1
// Rodri wins with 49/99 votes (49.49%)