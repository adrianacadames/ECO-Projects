/* Balon de Oro Correlations Check
Adriana Adames
Start 6-24-2025
*/


clear all

set obs 46 // set obs to number of ballon d'or winners

*Creating the vars
gen player = .
tostring player, replace
gen bmonth = .
gen bday = .
gen byear = .
gen country = .
tostring country, replace
gen winningyear1 = .
gen winningyear2 = .
gen winningyear3 = .
gen winningyear4 = .
gen winningyear5 = .
gen winningyear6 = .
gen winningyear7 = .
gen winningyear8 = .
gen Nwins = .

*Filling in the obs per player
replace player = "Stanley Matthews" in 1
replace bmonth = 2 in 1
replace bday = 1 in 1
replace byear = 1915 in 1
replace country = "England" in 1
replace winningyear1 = 1956 in 1
replace Nwins = 1 in 1

replace player = "Alfredo Di Stéfano" in 2
replace bmonth = 7 in 2
replace bday = 4 in 2
replace byear = 1926 in 2
replace country = "Argentina" in 2
replace winningyear1 = 1957 in 2
replace winningyear2 = 1959 in 2
replace Nwins = 2 in 2

replace player = "Raymond Kopa" in 3
replace bmonth = 10 in 3
replace bday = 13 in 3
replace byear = 1931 in 3
replace country = "France" in 3
replace winningyear1 = 1958 in 3
replace Nwins = 1 in 3

replace player = "Luis Suárez" in 4
replace bmonth = 5 in 4
replace bday = 2 in 4
replace byear = 1935 in 4
replace country = "Spain" in 4
replace winningyear1 = 1960 in 4
replace Nwins = 1 in 4

replace player = "Omar Sivori" in 5
replace bmonth = 10 in 5
replace bday = 2 in 5
replace byear = 1935 in 5
replace country = "Argentina" in 5
replace winningyear1 = 1961 in 5
replace Nwins = 1 in 5

replace player = "Josef Masopust" in 6
replace bmonth = 2 in 6
replace bday = 9 in 6
replace byear = 1931 in 6
replace country = "Czechia" in 6
replace winningyear1 = 1962 in 6
replace Nwins = 1 in 6

replace player = "Lev Yashin" in 7
replace bmonth = 10 in 7
replace bday = 22 in 7
replace byear = 1929 in 7
replace country = "Russia" in 7
replace winningyear1 = 1963 in 7
replace Nwins = 1 in 7

replace player = "Denis Law" in 8
replace bmonth = 2 in 8
replace bday = 24 in 8
replace byear = 1940 in 8
replace country = "Scotland" in 8
replace winningyear1 = 1964 in 8
replace Nwins = 1 in 8

replace player = "Eusébio" in 9
replace bmonth = 1 in 9
replace bday = 25 in 9
replace byear = 1942 in 9
replace country = "Portugal" in 9
replace winningyear1 = 1965 in 9
replace Nwins = 1 in 9

replace player = "Bobby Charlton" in 10
replace bmonth = 10 in 10
replace bday = 11 in 10
replace byear = 1937 in 10
replace country = "England" in 10
replace winningyear1 = 1966 in 10
replace Nwins = 1 in 10

replace player = "Flórián Albert" in 11
replace bmonth = 9 in 11
replace bday = 15 in 11
replace byear = 1941 in 11
replace country = "Hungary" in 11
replace winningyear1 = 1967 in 11
replace Nwins = 1 in 11

replace player = "George Best" in 12
replace bmonth = 5 in 12
replace bday = 22 in 12
replace byear = 1946 in 12
replace country = "Northern Ireland" in 12
replace winningyear1 = 1968 in 12
replace Nwins = 1 in 12

replace player = "Gianni Rivera" in 13
replace bmonth = 8 in 13
replace bday = 18 in 13
replace byear = 1943 in 13
replace country = "Italy" in 13
replace winningyear1 = 1969 in 13
replace Nwins = 1 in 13

replace player = "Gerd Müller" in 14
replace bmonth = 11 in 14
replace bday = 3 in 14
replace byear = 1945 in 14
replace country = "Germany" in 14
replace winningyear1 = 1970 in 14
replace Nwins = 1 in 14

replace player = "Johan Cruyff" in 15
replace bmonth = 4 in 15
replace bday = 25 in 15
replace byear = 1947 in 15
replace country = "Netherlands" in 15
replace winningyear1 = 1971 in 15
replace winningyear2 = 1973 in 15
replace winningyear3 = 1974 in 15
replace Nwins = 3 in 15

replace player = "Franz Beckenbauer" in 16
replace bmonth = 9 in 16
replace bday = 11 in 16
replace byear = 1945 in 16
replace country = "Germany" in 16
replace winningyear1 = 1972 in 16
replace winningyear2 = 1976 in 16
replace Nwins = 2 in 16

replace player = "Oleh Blokhin" in 17
replace bmonth = 11 in 17
replace bday = 5 in 17
replace byear = 1952 in 17
replace country = "Ukraine" in 17
replace winningyear1 = 1975 in 17
replace Nwins = 1 in 17

replace player = "Allan Simonsen" in 18
replace bmonth = 12 in 18
replace bday = 15 in 18
replace byear = 1952 in 18
replace country = "Denmark" in 18
replace winningyear1 = 1977 in 18
replace Nwins = 1 in 18

replace player = "Kevin Keegan" in 19
replace bmonth = 2 in 19
replace bday = 14 in 19
replace byear = 1951 in 19
replace country = "England" in 19
replace winningyear1 = 1978 in 19
replace winningyear2 = 1979 in 19
replace Nwins = 2 in 19

replace player = "Karl-Heinz Rummenigge" in 20
replace bmonth = 9 in 20
replace bday = 25 in 20
replace byear = 1955 in 20
replace country = "Germany" in 20
replace winningyear1 = 1980 in 20
replace winningyear2 = 1981 in 20
replace Nwins = 2 in 20

replace player = "Paolo Rossi" in 21
replace bmonth = 9 in 21
replace bday = 23 in 21
replace byear = 1956 in 21
replace country = "Italy" in 21
replace winningyear1 = 1982 in 21
replace Nwins = 1 in 21

replace player = "Michel Platini" in 22
replace bmonth = 6 in 22
replace bday = 21 in 22
replace byear = 1955 in 22
replace country = "France" in 22
replace winningyear1 = 1983 in 22
replace winningyear2 = 1984 in 22
replace winningyear3 = 1985 in 22
replace Nwins = 3 in 22

replace player = "Ihor Belanov" in 23
replace bmonth = 9 in 23
replace bday = 25 in 23
replace byear = 1960 in 23
replace country = "Ukraine" in 23
replace winningyear1 = 1986 in 23
replace Nwins = 1 in 23

replace player = "Ruud Gullit" in 24
replace bmonth = 9 in 24
replace bday = 1 in 24
replace byear = 1962 in 24
replace country = "Netherlands" in 24
replace winningyear1 = 1987 in 24
replace Nwins = 1 in 24

replace player = "Marco van Basten" in 25
replace bmonth = 10 in 25
replace bday = 31 in 25
replace byear = 1964 in 25
replace country = "Netherlands" in 25
replace winningyear1 = 1988 in 25
replace winningyear2 = 1989 in 25
replace winningyear3 = 1992 in 25
replace Nwins = 3 in 25

replace player = "Lothar Matthäus" in 26
replace bmonth = 3 in 26
replace bday = 21 in 26
replace byear = 1961 in 26
replace country = "Germany" in 26
replace winningyear1 = 1990 in 26
replace Nwins = 1 in 26

replace player = "Jean-Pierre Papin" in 27
replace bmonth = 11 in 27
replace bday = 5 in 27
replace byear = 1963 in 27
replace country = "France" in 27
replace winningyear1 = 1991 in 27
replace Nwins = 1 in 27

replace player = "Roberto Baggio" in 28
replace bmonth = 2 in 28
replace bday = 18 in 28
replace byear = 1967 in 28
replace country = "Italy" in 28
replace winningyear1 = 1993 in 28
replace Nwins = 1 in 28

replace player = "Hristo Stoichkov" in 29
replace bmonth = 2 in 29
replace bday = 8 in 29
replace byear = 1966 in 29
replace country = "Bulgaria" in 29
replace winningyear1 = 1994 in 29
replace Nwins = 1 in 29

replace player = "George Weah" in 30
replace bmonth = 10 in 30
replace bday = 1 in 30
replace byear = 1966 in 30
replace country = "Liberia" in 30
replace winningyear1 = 1995 in 30
replace Nwins = 1 in 30

replace player = "Matthias Sammer" in 31
replace bmonth = 9 in 31
replace bday = 5 in 31
replace byear = 1967 in 31
replace country = "Germany" in 31
replace winningyear1 = 1996 in 31
replace Nwins = 1 in 31

replace player = "Ronaldo" in 32
replace bmonth = 9 in 32
replace bday = 18 in 32
replace byear = 1976 in 32
replace country = "Brazil" in 32
replace winningyear1 = 1997 in 32
replace winningyear1 = 2002 in 32
replace Nwins = 2 in 32

replace player = "Zinédine Zidane" in 33
replace bmonth = 6 in 33
replace bday = 23 in 33
replace byear = 1972 in 33
replace country = "France" in 33
replace winningyear1 = 1998 in 33
replace Nwins = 1 in 33

replace player = "Rivaldo" in 34
replace bmonth = 4 in 34
replace bday = 19 in 34
replace byear = 1972 in 34
replace country = "Brazil" in 34
replace winningyear1 = 1999 in 34
replace Nwins = 1 in 34

replace player = "Luís Figo" in 35
replace bmonth = 11 in 35
replace bday = 4 in 35
replace byear = 1972 in 35
replace country = "Portugal" in 35
replace winningyear1 = 2000 in 35
replace Nwins = 1 in 35

replace player = "Michael Owen" in 36
replace bmonth = 12 in 36
replace bday = 14 in 36
replace byear = 1979 in 36
replace country = "England" in 36
replace winningyear1 = 2001 in 36
replace Nwins = 1 in 36

replace player = "Pavel Nedvěd" in 37
replace bmonth = 8 in 37
replace bday = 30 in 37
replace byear = 1972 in 37
replace country = "Czechia" in 37
replace winningyear1 = 2003 in 37
replace Nwins = 1 in 37

replace player = "Andriy Shevchenko" in 38
replace bmonth = 9 in 38
replace bday = 29 in 38
replace byear = 1976 in 38
replace country = "Ukraine" in 38
replace winningyear1 = 2004 in 38
replace Nwins = 1 in 38

replace player = "Ronaldinho" in 39
replace bmonth = 3 in 39
replace bday = 21 in 39
replace byear = 1980 in 39
replace country = "Brazil" in 39
replace winningyear1 = 2005 in 39
replace Nwins = 1 in 39

replace player = "Fabio Cannavaro" in 40
replace bmonth = 9 in 40
replace bday = 13 in 40
replace byear = 1973 in 40
replace country = "Italy" in 40
replace winningyear1 = 2006 in 40
replace Nwins = 1 in 40

replace player = "Kaká" in 41
replace bmonth = 4 in 41
replace bday = 22 in 41
replace byear = 1982 in 41
replace country = "Brazil" in 41
replace winningyear1 = 2007 in 41
replace Nwins = 1 in 41

replace player = "Cristiano Ronaldo" in 42
replace bmonth = 2 in 42
replace bday = 5 in 42
replace byear = 1985 in 42
replace country = "Portugal" in 42
replace winningyear1 = 2008 in 42
replace winningyear2 = 2013 in 42
replace winningyear3 = 2014 in 42
replace winningyear4 = 2016 in 42
replace winningyear5 = 2017 in 42
replace Nwins = 5 in 42

replace player = "Lionel Messi" in 43
replace bmonth = 6 in 43
replace bday = 24 in 43
replace byear = 1987 in 43
replace country = "Argentina" in 43
replace winningyear1 = 2009 in 43
replace winningyear2 = 2010 in 43
replace winningyear3 = 2011 in 43
replace winningyear4 = 2012 in 43
replace winningyear5 = 2015 in 43
replace winningyear6 = 2019 in 43
replace winningyear7 = 2021 in 43
replace winningyear8 = 2023 in 43
replace Nwins = 8 in 43

replace player = "Karim Benzema" in 44
replace bmonth = 12 in 44
replace bday = 19 in 44
replace byear = 1987 in 44
replace country = "France" in 44
replace winningyear1 = 2022 in 44
replace Nwins = 1 in 44

replace player = "Rodri" in 45
replace bmonth = 6 in 45
replace bday = 22 in 45
replace byear = 1996 in 45
replace country = "Spain" in 45
replace winningyear1 = 2022 in 45
replace Nwins = 1 in 45

*Create variable of age too
gen age1 = winningyear1-byear
gen age2 = winningyear2-byear
gen age3 = winningyear3-byear
gen age4 = winningyear4-byear
gen age5 = winningyear5-byear
gen age6 = winningyear6-byear
gen age7 = winningyear7-byear
gen age8 = winningyear8-byear

sum
pwcorr bmonth bday byear country winningyear1 winningyear2 winningyear3 winningyear4 winningyear5 winningyear6 winningyear7 winningyear8 Nwins age1 age2 age3 age4 age5 age6 age7 age8

pwcorr bmonth bday byear country winningyear1 winningyear2 winningyear3 winningyear4 winningyear5 winningyear6 winningyear7 winningyear8 Nwins age1 age2 age3 age4 age5 age6 age7 age8 if bmonth == 10

tab bmonth  /// september seems to be the month with most balon d'or winners
reg Nwins bmonth