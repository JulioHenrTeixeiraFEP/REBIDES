//////////////////////////////////////////////////////////////////////////////////////////////
//title: Data Merging and Appending
//author: Júlio Teixeira
//date: 08/03/2024
//objective: The goal is to merge the datasets with the datasets that have the unique identifiers and append all datasets. As the initial codes have some errors, changes are made.

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
log using "./Logs/Merge_Append", replace

*Step 2: Having already prepared the datasets one by one, now it's time to join them
//Our IDcodes are within their own dataset, so we use these loops to fetch them.
forvalues i = 2001/2012{
	use "${path1}\Data\Merged_Data\Merged_Data_`i'", clear
	merge m:1 numdocente using "${path1}\Data\ID_Codes\ids`i'", keep(3) noreport nogenerate keepusing(id_rebides)
	save "${path1}\Data\Merged_DataID\crebides`i'", replace
}

forvalues i = 2013/2015{
	use "${path1}\Data\Merged_Data\Merged_Data_`i'", clear
	merge m:1 iddocente using "${path1}\Data\ID_Codes\ids`i'", keep(3) noreport nogenerate keepusing(id_rebides)
	save "${path1}\Data\Merged_DataID\crebides`i'", replace
}

forvalues i = 2016/2018{
	use "${path1}\Data\Merged_Data\Merged_Data_`i'", clear
	merge m:1 iddocente idrh using "${path1}\Data\ID_Codes\ids`i'", keep(3) noreport nogenerate keepusing(id_rebides)
	save "${path1}\Data\Merged_DataID\crebides`i'", replace
}

forvalues i = 2019/2022{
	use "${path1}\Data\Merged_Data\Merged_Data_`i'", clear
	merge m:1 idrh_ieesp idrh_iecdes using "${path1}\Data\ID_Codes\ids`i'", keep(3) noreport nogenerate keepusing(id_rebides)
	save "${path1}\Data\Merged_DataID\crebides`i'", replace
}


//We make an attachment to obtain the final database.
use "${path1}\Data\Merged_DataID\crebides2022", clear
forvalues i = 2001/2021{
	append using "${path1}\Data\Merged_DataID\crebides`i'"
}
sort Year

//id_rebides corrections
standardizetext Name, stopwords(DOS DAS DO DA DE DES E) gen(Nam)
drop Name
rename Nam Name
sort Name Year
by Name: egen first_code = min(id_rebides)
bysort Name: gen diff_code = id_rebides != first_code
bysort Name (Year): replace id_rebides = first_code if diff_code == 1 
drop first_code diff_code
order Year id_rebides Name	


//It is clear that there are some cases of higher education professors with the same name, and we deal with this in two ways: on the one hand, we use the highest degree progression and the HEI to distinguish professors. So, if a professor goes from a Master's to a Bachelor's degree, in different institutions, we assume he or she is a different person, for example. This prevents errors in completing the survey from causing more different professors to be detected than should be; on the other hand, looking at the data set in question, we could observe some other cases not detected in this way.

sort id_rebides Year 

destring Year, replace
gen Degr = 0 
replace Degr = 1 if (Degree[_n-1] == "DOCTOR 3 CYCLE" & (Degree == "BACHELOR 1 CYCLE" | Degree == "MASTER 2 CYCLE") & id_rebides == id_rebides[_n-1]) | (Degree[_n-1] == "MASTER 2 CYCLE" & Degree == "BACHELOR 1 CYCLE" & id_rebides == id_rebides[_n-1]) & Year == Year[_n-1]+1

gen Estab = 0 
replace Estab = 1 if Establishment != Establishment[_n-1] & id_rebides == id_rebides[_n-1] & Year == Year[_n-1]+1 & Degr == 1

egen var = group(Name Establishment)
gen id = var+700000
bys var: egen maximo = max(Estab)
replace id_rebides = id if maximo == 1

drop id maximo var Estab Degr


compress
save "${path1}\Data\Full_Data\Merged_REBIDES", replace

log close