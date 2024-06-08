program define varscontrAct

keep IDRH_IEESP IDRH_IECDES Númerodehorasdedocênciado1 Númerodehorasdedocênciado2 R Unidademedidahorasdocênciado Códigounidadeorgânica

//The data from recent years has something that differentiates it from the others: it has working hours for each of the semesters. Therefore, taking an average could lead us to more robust results about working time. However, we need to take into account professors who have different units of measurement for working time, to which we apply the following methodology, changing the unit of measurement to weekly for all of them. We assume that a month has 4 weeks, a semester has 6 months and a year has 12 months.
replace Númerodehorasdedocênciado1 = Númerodehorasdedocênciado1/24 if R != Unidademedidahorasdocênciado & Unidademedidahorasdocênciado == "Semestrais" //semi-annual to weekly
replace Númerodehorasdedocênciado2 = Númerodehorasdedocênciado2/24 if R != Unidademedidahorasdocênciado & R == "Semestrais" //semi-annual to weekly
replace Númerodehorasdedocênciado2 = Númerodehorasdedocênciado2/48 if R != Unidademedidahorasdocênciado & R == "Anuais" //annual to weekly
replace Númerodehorasdedocênciado1 = Númerodehorasdedocênciado1/48 if R != Unidademedidahorasdocênciado & Unidademedidahorasdocênciado == "Anuais" //annual to weekly
replace Númerodehorasdedocênciado2 = Númerodehorasdedocênciado2/4 if R != Unidademedidahorasdocênciado & R == "Mensais" //monthly to weekly
replace Númerodehorasdedocênciado1 = Númerodehorasdedocênciado1/4 if R != Unidademedidahorasdocênciado & Unidademedidahorasdocênciado == "Mensais" //monthly to weekly
replace R = "Semanais" if R != Unidademedidahorasdocênciado | R == Unidademedidahorasdocênciado
replace Unidademedidahorasdocênciado = "Semanais" if R != Unidademedidahorasdocênciado | R == Unidademedidahorasdocênciado

**here we have the mean between both semesters
bysort IDRH_IEESP IDRH_IECDES: gen Classhours = (Númerodehorasdedocênciado1 + Númerodehorasdedocênciado2) / 2 

// We rename the variables with a unique name, which will be used in all data sets, so that in the end it will be possible to link all data without problems.

rename IDRH_IEESP idrh_ieesp
rename IDRH_IECDES idrh_iecdes
rename Unidademedidahorasdocênciado Unit_Classhours
rename Códigounidadeorgânica Organic_Unit_Code
drop R Númerodehorasdedocênciado2 Númerodehorasdedocênciado1 

//To delete the labels that accompany the variables, as it is enough for a set of data to have the correct label (when connecting the years, they all have the same label)
foreach var of varlist _all {
	label var `var' ""
}


tostring Organic_Unit_Code, replace
replace Organic_Unit_Code = substr(Organic_Unit_Code, 2, 4)


end