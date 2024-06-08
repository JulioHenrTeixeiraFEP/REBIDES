program define varscontr

keep ETIRemuneradoContrato IDRH_IEESP IDRH_IECDES AnoReferência Subsistemadeensino Códigoestabelecimento Estabelecimento Códigounidadeorgânica Unidadeorgânica Nomecompleto DataInicioContrato Regimedeprestaçãodeserviço Categoria // We choose the variables we want from this data set. It should be noted that the last 4 years have more information available, which we will want to use in our work.

// We rename the variables with a unique name, which will be used in all data sets, so that in the end it will be possible to link all data without problems.

rename IDRH_IEESP idrh_ieesp
rename IDRH_IECDES idrh_iecdes
rename ETIRemuneradoContrato Perc_Parc_Reg
rename AnoReferência Year 
rename Subsistemadeensino Teaching_subsystem
rename Códigoestabelecimento Establishment_Code
rename Estabelecimento Establishment
rename Códigounidadeorgânica Organic_Unit_Code
rename Unidadeorgânica Organic_Unit
rename Nomecompleto Name
rename DataInicioContrato Contract_Start_Date
rename Regimedeprestaçãodeserviço Prest_Reg
rename Categoria Categ

//To delete the labels that accompany the variables, as it is enough for a set of data to have the correct label (when connecting the years, they all have the same label)
foreach var of varlist _all {
	label var `var' ""
}

//Here, we are dealing with a problem that, although not very recurrent in databases referring to different years, still needs to be resolved. The variable referring to the organic unit code sometimes appears in numerical format, and additionally, with more digits than in other years. Therefore, as it is simpler to remove characters in years where there are more than normal, than to add in codes where there are fewer, it was decided to standardize the code into 4 numbers, in string format.
tostring Organic_Unit_Code, replace
replace Organic_Unit_Code = substr(Organic_Unit_Code, 2, 4)

//We do this, for now, without standardizing the text, but we correct possible errors later on. We only do this now because most years already have this variable, and so we end up with a more cohesive final data set (after the merge).
gen Guest = 1 if regexm(Categ, "Convidado")
replace Guest = 1 if regexm(Categ, "convidado")
replace Guest = 0 if Guest == . 

//In order to normalize the unit of measurement used.
replace Perc_Parc_Reg = Perc_Parc_Reg*100

end