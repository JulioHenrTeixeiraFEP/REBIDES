//////////////////////////////////////////////////////////////////////////////////////////////
//title: Data reading and selection 
//author: Júlio Teixeira
//date: 08/03/2024
//objective: In this do-file we perform a selection of the data that we will use, in addition to transferring them to STATA format. Essentially, we import the information from Excel into STATA, create the missing variables in some data sets, in order to eliminate difficulties in the following steps, and format the variables the way we want.

************************************************************************************************
//To make sure the code runs smoothly
clear all
capture log close
program drop _all
set more off
*version 18
************************************************************************************************

//////////////////////////////////////////////
//Define the main path (insert the directory corresponding to the user here)
global path1 "C:/Users/julio/Desktop/Dataset"
adopath ++ "${path1}/Progs/Ado"
//////////////////////////////////////////////

*Step 1: Changing the working directory, and starting the log
cd "${path1}"
log using "./Logs/Datasets_Selection", replace

*Step 2: Database importation
*************************************************************************************************
//From now on the code is divided between years. We start with the most recent year and go until the oldest available. The information is divided between different Excel sheets for each year, so there is a need to treat them separately.
*************************************************************************************************

**********
**22/23**
**********

********** Contract related data **********
import excel "${path1}/Source/REBIDES_Source/REBIDES_22_23", sheet("Contrato") firstrow clear //We imported the Excel spreadsheet "Contrato" from 22/23.

varscontr //We choose and format the variables we are going to use. Furthermore, some specific treatments are being done, removing labels, changing variable names and creating in some datasets some variables that are not directly available in that year.

save "${path1}/Data/Contract_Source_STATA/Contractunf_2022", replace // We save the cleaned database in STATA format.

//In the last 4 years, there are variables that we want to use in our analysis, which would normally be associated with the contract, but which are found in a separate "Atividades" tab. Here we will "fetch" them from this Excel page to use them later.
import excel "${path1}\Source\REBIDES_Source\REBIDES_22_23", sheet("Atividades") firstrow clear

varscontrAct //To select the vars we need from this Excel sheet.

save "${path1}/Data/Contract_Source_STATA/Activities_2022", replace

//Here we combine the 2 layers of information.
clear all
use "${path1}/Data/Contract_Source_STATA/Contractunf_2022"
merge m:1 idrh_ieesp idrh_iecdes using "${path1}/Data/Contract_Source_STATA/Activities_2022", keepusing(Unit_Classhours Classhours) 
drop _merge
save "${path1}/Data/Contract_Source_STATA/Contract_2022", replace


********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_22_23", sheet("HabilitacaoMaisElevada") firstrow clear //We imported the Excel spreadsheet "HabilitacaoMaisElevada" from 22/23.

varsdegr //We choose and format the variables we are going to use.

save "${path1}/Data/Degree_Source_STATA/Degree_2022", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**21/22**
**********

********** Contract related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_21_22", sheet("Contrato") firstrow clear

varscontr 

save "${path1}/Data/Contract_Source_STATA/Contractunf_2021", replace

import excel "${path1}\Source\REBIDES_Source\REBIDES_21_22", sheet("Atividades") firstrow clear

varscontrAct

save "${path1}/Data/Contract_Source_STATA/Activities_2021", replace

//Here we combine the 2 layers of information.
clear all
use "${path1}/Data/Contract_Source_STATA/Contractunf_2021"
merge m:1 idrh_ieesp idrh_iecdes using "${path1}/Data/Contract_Source_STATA/Activities_2021", keepusing(Unit_Classhours Classhours) 
drop _merge

save "${path1}/Data/Contract_Source_STATA/Contract_2021", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_21_22", sheet("HabilitacaoMaisElevada") firstrow clear

varsdegr

save "${path1}/Data/Degree_Source_STATA/Degree_2021", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


**********
**20/21**
**********

********** Contract related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_20_21", sheet("Contrato") firstrow clear

varscontr

save "${path1}/Data/Contract_Source_STATA/Contractunf_2020", replace

import excel "${path1}\Source\REBIDES_Source\REBIDES_20_21", sheet("Atividades") firstrow clear

varscontrAct

save "${path1}/Data/Contract_Source_STATA/Activities_2020", replace

//Here we combine the 2 layers of information.
clear all
use "${path1}/Data/Contract_Source_STATA/Contractunf_2020"
merge m:1 idrh_ieesp idrh_iecdes using "${path1}/Data/Contract_Source_STATA/Activities_2020", keepusing(Unit_Classhours Classhours) 
drop _merge

save "${path1}/Data/Contract_Source_STATA/Contract_2020", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_20_21", sheet("HabilitacaoMaisElevada") firstrow clear

varsdegr

save "${path1}/Data/Degree_Source_STATA/Degree_2020", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**19/20**
**********

********** Contract and Activities related data ********** 
import excel "${path1}\Source\REBIDES_Source\REBIDES_19_20", sheet("Contrato") firstrow clear

varscontr

//So that the date appears in the same format as other years (taking into account that in this case the information in Excel came in a different format)
generate Contract_Start = string(Contract_Start_Date , "%tcnn/dd/ccYY")
drop Contract_Start_Date
generate Contract_Start_Date = date(Contract_Start,"MDY")
format %tdCCYY-NN-DD Contract_Start_Date
drop Contract_Start
generate Contract_Start = string(Contract_Start_Date , "%tdCCYY-NN-DD")
drop Contract_Start_Date
rename Contract_Start Contract_Start_Date


save "${path1}/Data/Contract_Source_STATA/Contractunf_2019", replace

import excel "${path1}\Source\REBIDES_Source\REBIDES_19_20", sheet("Atividades") firstrow clear

varscontrAct

save "${path1}/Data/Contract_Source_STATA/Activities_2019", replace

//Here we combine the 2 layers of information.
clear all
use "${path1}/Data/Contract_Source_STATA/Contractunf_2019"
merge m:1 idrh_ieesp idrh_iecdes using "${path1}/Data/Contract_Source_STATA/Activities_2019", keepusing(Unit_Classhours Classhours) 
drop _merge


save "${path1}/Data/Contract_Source_STATA/Contract_2019", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_19_20", sheet("HabilitacaoMaisElevada") firstrow clear

varsdegr

save "${path1}/Data/Degree_Source_STATA/Degree_2019", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


**********
**18/19**
**********

//The following data sets have the particularity of having the information divided into more Excel pages (namely, between private and public HEIs). Therefore, the treatment will also be carried out separately.

********** Contract related data - public HEI ********** 
import excel "${path1}\Source\REBIDES_Source\REBIDES_18_19.xlsx", sheet("Categoria_IEESP") firstrow clear
varscontr1
gen Year = 2018 //In order know the reference year to which the data refers.
tostring Year, replace //To ensure that the variable has the same format in the various datasets.


save "${path1}/Data/Contract_Source_STATA/Contract_publichei_2018", replace


********** Contract related data - private HEI **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_18_19.xlsx", sheet("Carreira_Rebides") firstrow clear
varscontr2
gen Year = 2018 //In order know the reference year to which the data refers.
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_privatehei_2018", replace

append using "${path1}/Data/Contract_Source_STATA/Contract_publichei_2018", force //In order to combine information referring to the same variables and year layer.
save "${path1}/Data/Contract_Source_STATA/Contract_2018", replace

********** Degree related data - public HEI **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_18_19.xlsx", sheet("HabilitaçãoMaisElevada_IEESP") firstrow clear

varsdegr1

save "${path1}/Data/Degree_Source_STATA/Degree_publichei_2018", replace


********** Degree related data - private HEI **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_18_19.xlsx", sheet("Habilitacoes_Rebides") firstrow clear

varsdegr2

save "${path1}/Data/Degree_Source_STATA/Degree_privatehei_2018", replace


append using "${path1}/Data/Degree_Source_STATA/Degree_publichei_2018", force
save "${path1}/Data/Degree_Source_STATA/Degree_2018", replace

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**17/18**
**********

********** Contract related data - public HEI ********** 
import excel "${path1}\Source\REBIDES_Source\REBIDES_17_18.xlsx", sheet("Categoria_IEESP") firstrow clear
varscontr3
gen Year = 2017
tostring Year, replace


save "${path1}/Data/Contract_Source_STATA/Contract_publichei_2017", replace

********** Contract related data - private HEI ********** 
import excel "${path1}\Source\REBIDES_Source\REBIDES_17_18.xlsx", sheet("Carreira_Rebides") firstrow clear
varscontr4
gen Year = 2017
tostring Year, replace
 

save "${path1}/Data/Contract_Source_STATA/Contract_privatehei_2017", replace

append using "${path1}/Data/Contract_Source_STATA/Contract_publichei_2017", force
save "${path1}/Data/Contract_Source_STATA/Contract_2017", replace

********** Degree related data - public HEI **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_17_18.xlsx", sheet("HabilitaçãoMaisElevada_IEESP") firstrow clear

varsdegr1

save "${path1}/Data/Degree_Source_STATA/Degree_publichei_2017", replace

********** Degree related data - private HEI **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_17_18.xlsx", sheet("Habilitacoes_Rebides") firstrow clear

varsdegr2

save "${path1}/Data/Degree_Source_STATA/Degree_privatehei_2017", replace

append using "${path1}/Data/Degree_Source_STATA/Degree_publichei_2017", force
save "${path1}/Data/Degree_Source_STATA/Degree_2017", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**16/17**
**********

********** Contract related data - public HEI ********** 
import excel "${path1}\Source\REBIDES_Source\REBIDES_16_17.xlsx", sheet("Carreira_RebidesIndez") firstrow clear
varscontr5
gen Year = 2016
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_publichei_2016", replace

********** Contract related data - private HEI ********** 
import excel "${path1}\Source\REBIDES_Source\REBIDES_16_17.xlsx", sheet("Carreira_Rebides") firstrow clear

varscontr6
gen Year = 2016
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_privatehei_2016", replace

append using "${path1}/Data/Contract_Source_STATA/Contract_publichei_2016", force
save "${path1}/Data/Contract_Source_STATA/Contract_2016", replace

********** Degree related data - public HEI **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_16_17.xlsx", sheet("HabilitacaoMaisElevada") firstrow clear

varsdegr1

save "${path1}/Data/Degree_Source_STATA/Degree_publichei_2016", replace


********** Degree related data - private HEI **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_16_17.xlsx", sheet("Habilitacao_Rebides") firstrow clear

varsdegr3

save "${path1}/Data/Degree_Source_STATA/Degree_privatehei_2016", replace

append using "${path1}/Data/Degree_Source_STATA/Degree_publichei_2016", force
save "${path1}/Data/Degree_Source_STATA/Degree_2016", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**15/16**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_15_16.xlsx", sheet("CarreiraAtividades1516") firstrow clear
varscontr7
gen Year = 2015
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2015", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_15_16.xlsx", sheet("Habilitacoes1516") firstrow clear

varsdegr4

save "${path1}/Data/Degree_Source_STATA/Degree_2015", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**14/15**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_14_15.xlsx", sheet("CarreiraAtividades1415") firstrow clear

varscontr7
gen Year = 2014
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2014", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_14_15.xlsx", sheet("Habilitacoes1415") firstrow clear

varsdegr4

save "${path1}/Data/Degree_Source_STATA/Degree_2014", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**13/14**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_13_14.xlsx", sheet("CarreiraAtividades1314") firstrow clear
varscontr8
gen Year = 2013
tostring Year, replace
 

save "${path1}/Data/Contract_Source_STATA/Contract_2013", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_13_14.xlsx", sheet("Habilitacoes1314") firstrow clear

varsdegr5


save "${path1}/Data/Degree_Source_STATA/Degree_2013", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**12/13**
**********

********** Contract related data **********   
import excel "${path1}\Source\REBIDES_Source\REBIDES_12_13.xlsx", sheet("Carreira_RB1213") firstrow clear
varscontr9
gen Year = 2012
tostring Year, replace
 

save "${path1}/Data/Contract_Source_STATA/Contract_2012", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_12_13.xlsx", sheet("Habilitacoes_RB1213") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2012", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**11/12**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_11_12.xlsx", sheet("Carreira_RB1112") firstrow clear
varscontr9
gen Year = 2011
tostring Year, replace


save "${path1}/Data/Contract_Source_STATA/Contract_2011", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_11_12.xlsx", sheet("Habilitacoes_RB1112") firstrow clear

varsdegr6


save "${path1}/Data/Degree_Source_STATA/Degree_2011", replace

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**10/11**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_10_11.xlsx", sheet("Carreira_RB1011") firstrow clear
varscontr9
gen Year = 2010
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2010", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_10_11.xlsx", sheet("Habilitacoes_RB1011") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2010", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**09/10**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_09_10.xlsx", sheet("Carreira_RB0910") firstrow clear
varscontr9
gen Year = 2009
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2009", replace


********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_09_10.xlsx", sheet("Habilitacoes_RB0910") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2009", replace
 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**08/09**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_08_09.xlsx", sheet("Carreira_RB0809") firstrow clear
varscontr9
gen Year = 2008
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2008", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_08_09.xlsx", sheet("Habilitacoes_RB0809") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2008", replace

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**07/08**
**********
 
********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_07_08.xlsx", sheet("Carreira_RB0708") firstrow clear
varscontr9
gen Year = 2007
tostring Year, replace
 
save "${path1}/Data/Contract_Source_STATA/Contract_2007", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_07_08.xlsx", sheet("Habilitacoes_RB0708") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2007", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**06/07**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_06_07.xlsx", sheet("Carreira_RB0607") firstrow clear
varscontr9
gen Year = 2006
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2006", replace


********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_06_07.xlsx", sheet("Habilitacoes_RB0607") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2006", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**05/06**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_05_06.xlsx", sheet("Carreira_RB0506") firstrow clear
varscontr9
gen Year = 2005
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2005", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_05_06.xlsx", sheet("Habilitacoes_RB0506") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2005", replace

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**04/05**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_04_05.xlsx", sheet("Carreira_RB0405") firstrow clear
varscontr9
gen Year = 2004
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2004", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_04_05.xlsx", sheet("Habilitacoes_RB0405") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2004", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**03/04**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_03_04.xlsx", sheet("Carreira_RB0304") firstrow clear
varscontr9
gen Year = 2003
tostring Year, replace


save "${path1}/Data/Contract_Source_STATA/Contract_2003", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_03_04.xlsx", sheet("Habilitacoes_RB0304") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2003", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**02/03**
**********

********** Contract related data **********  
import excel "${path1}\Source\REBIDES_Source\REBIDES_02_03.xlsx", sheet("Carreira_RB0203") firstrow clear
varscontr9
gen Year = 2002
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2002", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_02_03.xlsx", sheet("Habilitacao_RB0203") firstrow clear

varsdegr6

save "${path1}/Data/Degree_Source_STATA/Degree_2002", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

**********
**01/02**
**********

********** Contract related data **********   
import excel "${path1}\Source\REBIDES_Source\REBIDES_01_02.xlsx", sheet("Carreira_RB0102") firstrow clear
varscontr9
gen Year = 2001
tostring Year, replace

save "${path1}/Data/Contract_Source_STATA/Contract_2001", replace

********** Degree related data **********
import excel "${path1}\Source\REBIDES_Source\REBIDES_01_02.xlsx", sheet("Habilitacoes_RB0102") firstrow clear

varsdegr6


save "${path1}/Data/Degree_Source_STATA/Degree_2001", replace


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


log close