//////////////////////////////////////////////////////////////////////////////////////////////
//title: Final Data Cleaning
//author: Júlio Teixeira
//date: 09/03/2024
//objective: The goal is to make the final preparations for the empirical part.
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
log using "./Logs/Final_Cleaning", replace

**installs needed: net install bpencode, from("https://github.com/BPLIM/Tools/raw/master/ados/General/bpencode")

*Step 2: Dataset cleaning
use "${path1}\Data\Full_Data\Merged_REBIDES", clear

//So we can organize ourselves better.
order Year id_rebides Name Teaching_subsystem Establishment_Code Establishment Organic_Unit_Code Organic_Unit Degree Degree_Country_Code Degree_Year CNAEF_area Categ GEN_Categ Prest_Reg Guest Classhours Unit_Classhours Perc_Parc_Reg Service_Years idrh_iecdes idrh numdocente iddocente id_rebides 

//Now, solving problems related to missing values.
replace Degree_Country_Code = "." if  Degree_Country_Code == ""
replace Degree_Country_Code = "ND" if Year > 2018 & Degree_Country_Code == "." //For this variable we only have information after 2018. Therefore, for missing values in the interval between 2019/2022 we consider ND - Not Defined
replace Degree_Year = "." if  Degree_Year == ""
destring Degree_Year, replace
replace GenArea = "." if  GenArea == "" & Year > 2018
replace GenArea = "ND" if  GenArea == "." & Year > 2018
replace Guest = 0 if Guest == . //If we don't have information, we assume the professor is not a guest.
replace GenArea = "." if GenArea == ""
replace Contract_Start_Date = "." if Contract_Start_Date == ""
replace District = "." if District == ""
replace NUTS2 = "." if NUTS2 == ""
gen class_hours = round(Classhours, 0.1)
label var class_hours "Teaching hours"
rename Classhours ORIGINAL_Classhours
label var ORIGINAL_Classhours "Teaching hours (from the original Excel)"
replace GEN_Categ = "ND" if GEN_Categ == "."
replace GenArea = "ND" if GenArea == "." & Year > 2018
replace Cat = "ND" if Cat == "."
replace Prest_Reg = "ND" if Prest_Reg == "."


//Moving on to variable formatting and normalization.
//We start encoding the CNAEF areas
label define GenArealbl 1 "GENERIC PROGRAMS AND QUALIFICATIONS" 2 "EDUCATION" 3 "ARTS AND HUMANITIES" 4 "SOCIAL SCIENCES JOURNALISM AND INFORMATION" 5 "BUSINESS SCIENCES ADMINISTRATION AND LAW" 6 "NATURAL SCIENCES MATHEMATICS AND STATISTICS" 7 "INFORMATION AND COMMUNICATION TECHNOLOGIES ICTS" 8 "ENGINEERING MANUFACTURING AND CONSTRUCTION INDUSTRIES" 9 "AGRICULTURE FORESTRY FISHERIES AND VETERINARY SCIENCES" 10 "HEALTH AND SOCIAL PROTECTION" 11 "SERVICES" 12 "UNKNOWN AREA" 13 "ND"
encode GenArea, label(GenArealbl) gen(GenAre)
drop GenArea 
rename GenAr GenArea
compress

//In the educational subsystems, we move into a more basic correspondence. The only problem is the class that does not specify the type of educational establishment ("OUTROS ESTABELECIMENTOS"). We take care of this by placing the first subsystem that appears in the dataset (in 2005) for the establishment, and when in doubt, when it disappears from the dataset, we base it on the type of hierarchical categories that the establishment had. Furthermore, we created a new classification for universities, placing the same establishment code, for example, for universities that merged, in order to facilitate the empirical analysis. To homogenize the data:
estabsysclean

//Treating variables that were, until now, as strings, and encoding them:
destring Year, replace //Reference Year
destring Degree_Year, replace //Year of the highest degree
destring Establishment_Code, replace //There is no problem destringing this code, since there are no dubious cases raised due to zeros "before".

label define Degreelbl 1 "ND" 2 "BACHELOR 1 CYCLE" 3 "MASTER 2 CYCLE" 4 "DOCTOR 3 CYCLE" //We define a label for Degree by hand, in order to place the cycles in order
encode Degree, gen(Degr) label(Degreelbl)
drop Degree
rename Degr Degree

label define GENCateglbl 1 "ND" 2 "OTHER" 3 "TEACHING ASSISTANT" 4 "ASSISTANT PROFESSOR" 5 "ASSOCIATE PROFESSOR" 6 "FULL PROFESSOR"
encode GEN_Categ, gen(gen_categ) label(GENCateglbl)
drop GEN_Categ

label define Categlbl 1 "ND" 2 "OTHER" 3 "MILITARY POSITIONS" 4 "ICT" 5 "MEDICAL POSITIONS" 6 "MANAGEMENT POSITIONS" 7 "RESEARCH POSITIONS" 8 "TEACHING ASSISTANT" 9 "ASSISTANT PROFESSOR" 10 "ASSOCIATE PROFESSOR" 11 "FULL PROFESSOR"
encode Categ, gen(Cat) label(Categlbl)
drop Categ
rename Cat Categ

standardizetext NUTS2, upper gen(NTS2) //we already standardized this, but we choose to put it upper, as the other variables
label var NTS2 "NUTS II location identification"
drop NUTS2
rename NTS2 NUTS2
standardizetext District, upper gen(Distr)
label var Distr "Institution location district"
drop District
rename Distr District

//We now encode the NUTS2 and the District
label define NUTS2lbl 1 "NORTE" 2 "CENTRO" 3 "OESTE E VALE DO TEJO" 4 "GRANDE LISBOA" 5 "PENINSULA DE SETUBAL" 6 "ALENTEJO" 7 "ALGARVE" 8 "REGIAO AUTONOMA DA MADEIRA" 9 "REGIAO AUTONOMA DOS ACORES"
encode NUTS2, label(NUTS2lbl) gen(NTS2) //NUTS2
drop NUTS2
rename NTS2 NUTS2

encode District, gen(Distr) //District
label var Distr "Institution location district"
drop District
rename Distr District

//To find out whether the obtained diploma is international or not:
gen IntGrad = 1 if Degree_Country_Code != "PT"
replace IntGrad = 0 if Degree_Country_Code == "PT" | Degree_Country_Code == "ND" | Degree_Country_Code == "." //We assume that the uncompleted cases are from people who did not take the course outside the country.
replace IntGrad = . if  IntGrad == 0 & Year<2019 
label var IntGrad "International (highest) graduation" 

//Encoding the country in which the professor took its highest degree
encode Degree_Country_Code, gen (Degr_Country_Cod) 
drop Degree_Country_Code 
rename Degr_Country_Cod Degree_Country_Code

//Encoding the professions category
label var Name "Full name of the professor"
label var id_rebides "Unique identifier code produced by us"
label var ORIGINAL_Categ "Profession category (from the original Excel)"
label var ORIGINAL_ORG_UNIT_CODE "Organic unit identifier code (from the original Excel)"
label var ORIGINAL_TEACH_SUB "Original teaching subsystem (from the original Excel)"
label var ORIGINAL_ESTAB_COD "Original establishment code (from the original Excel)"
label var ORIGINAL_ESTAB_COD "Original establishment code (from the original Excel)"
label var ORIGINAL_Prest_Reg "Original prestation regime (from the original Excel)"
label var gen_categ "General profession category (everything that does not belong to the main categories is characterized as other)"

//Encoding the working regime
label define Prest_Reglbl 1 "ND" 2 "OTHER" 3 "COLLABORATION" 4 "PART TIME" 5 "FULL TIME" 6 "EXCLUSIVE" 
encode Prest_Reg, gen(Prest) label(Prest_Reglbl)
drop Prest_Reg
rename Prest Prest_Reg
label var Prest_Reg "Service provision regime"

*Correcting some mistakes from the original Excel and sending away irrelevant information.
label var class_hours "Teaching hours (weekly)"
drop Unit_Classhours 
replace Perc_Parc_Reg = Perc_Parc_Reg/100 //putting the percentage of partial time work in the range 0-1
gen start_date = date(Contract_Start_Date, "YMD")
format %tdNN/DD/CCYY start_date
label var start_date "Date when the contract started"
rename Contract_Start_Date ORIGINAL_Contract_Start_Date
rename start_date contract_start_date
label var ORIGINAL_Contract_Start_Date "Date when the contract started (from the original Excel)"

order Year id_rebides Name Teach_sub Establishment_Code Establishment Organic_Unit_Code Organic_Unit Degree Degree_Year Degree_Country_Code IntGrad CNAEF_area Categ Cat ORIGINAL_Categ Prest_Reg Prest_R ORIGINAL_TEACH_SUB Teach_Sub_Code ORIGINAL_ESTAB_COD ORIGINAL_ORG_UNIT_CODE

drop Teach_Sub_Code 
rename Teach_sub Teaching_subsystem


//Putting all variables with their name in lowercase...
rename Year year 
rename Name name
rename Teaching_subsystem teaching_subsystem 
rename Establishment_Code establishment_code
rename Establishment establishment
rename Organic_Unit_Code organic_unit_code
rename Organic_Unit organic_unit
rename Degree degree
rename Degree_Year degree_year
rename Degree_Country_Code degree_country_code
rename IntGrad intgrad
rename CNAEF_area cnaef_area
rename Categ categ
rename ORIGINAL_Categ original_categ
rename ORIGINAL_TEACH_SUB original_teach_sub
rename Guest guest
rename ORIGINAL_ESTAB_COD original_estab_cod
rename ORIGINAL_ORG_UNIT_CODE original_org_unit_code
rename Prest_Reg prest_reg
rename ORIGINAL_Classhours original_classhours
rename Service_Years service_years
rename Perc_Parc_Reg perc_parc_reg
rename ORIGINAL_Contract_Start_Date original_contract_start_date
rename ORIGINAL_Prest_Reg original_prest_reg
rename GenArea genarea
rename NUTS2 nuts2
rename District district


save "${path1}\Data\Full_Data\Full_REBIDES", replace
log close

