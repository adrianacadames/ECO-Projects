/* Adriana Adames
6-22-2025
Side Project #1: 
Are the states that have similar climates (temperatures) emitting similar amounts of C02 through the years? If so, are these the ones less green?
*/

***This might just show correlation but it is a good use of STATA practice

// Independent Var = State CO2 Emissions
// Dependent Var = State temperature

* Load state CO2 emissions from https://www.eia.gov/environment/emissions/state/
 import excel "C:\Users\adria\Documents\Side Project\State energy related carbon dioxide emissions by year (1970-2022).xlsx", sheet("Table 1") cellrange(A5:BF57) firstrow clear

*Clean data and rename year variable names
rename (B C D E F G H I J K) y197#, addnumber(0) // This will rename all 1970s vars as yyear
rename (L M N O P Q R S T U) y198#, addnumber(0) // This will rename all 1980s vars as yyear
rename  (V W X Y Z AA AB AC AD AE) y199#, addnumber(0) // This will rename all 1990s vars as yyear
rename (AF AG AH AI AJ AK AL AM AN AO AP AQ AR AS AT AU AV AW AX AY AZ BA BB) y20#, addnumber(0) // This will rename all 2000 and above vars as yyear

drop Percent Absolute BE BF

* Load State temperature just for Alabama from 

**Clean and merge to see