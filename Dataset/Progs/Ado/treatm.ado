program define treatm

//To make sure everything is right, since we created this variable before cleaning/treating the text from the dataset.
replace Guest = 1 if regexm(Categ, "CONVIDADO")
replace Guest = 0 if Guest == .

//It would be helpful to put the school timetable in the same format for all professors.
//We start by turning annual hours into semi-annual hours
replace Classhours = Classhours/2 if Unit_Classhours == "ANUAIS" | Unit_Classhours == "A"
replace Unit_Classhours = "SEMESTRAIS" if Unit_Classhours == "ANUAIS" | Unit_Classhours == "A"
//Switching now to monthly hours
replace Classhours = Classhours/6 if Unit_Classhours == "SEMESTRAIS" 
replace Unit_Classhours = "MENSAIS" if Unit_Classhours == "SEMESTRAIS" 
//Switching now to weekly hours
replace Classhours = Classhours/4 if Unit_Classhours == "MENSAIS" | Unit_Classhours == "M"
replace Unit_Classhours = "SEMANAIS" if Unit_Classhours == "MENSAIS" | Unit_Classhours == "M"


//An extra clean up
replace Classhours = . if missing(Classhours)
replace Prest_Reg  = "." if missing(Prest_Reg)
replace Categ  = "." if missing(Categ)
replace Unit_Classhours = "." if missing(Unit_Classhours)

//Now we have to take into account that sometimes this variable can have incorrectly filled values. When summarizing, we can see this immediately, with an absurd maximum value. We defined a maximum value sufficiently comprehensive to take into account the 8 (normal) daily working hours dedicated to teaching (8x5=40).
replace Classhours = . if Classhours>40

replace Perc_Parc_Reg = 100 if Prest_Reg == "DEDICACAO EXCLUSIVA" //To fill in the most obvious information that is not populated in the datasets (we assume someone full-time or full-time is paid 100% of the time)
replace Perc_Parc_Reg = 100 if Prest_Reg == "TEMPO INTEGRAL" | Prest_Reg == "TEMPO INTEGRAL COM DEDICACAO EXCLUSIVA" | Prest_Reg == "REGIME DE TENURE"
replace Unit_Classhours = "SEMANAIS" if Unit_Classhours == "S"
replace Unit_Classhours = "ANUAIS" if Unit_Classhours == "A"

//To be able to obtain the years of service of the person in that position (approximately).
gen start_date = date(Contract_Start_Date, "YMD")
format %tdCCYY-NN-DD start_date
gen start_year = year(start_date)
gen ref_year = real(Year)
gen Service_Years = ref_year - start_year
drop start_date start_year ref_year 


end


