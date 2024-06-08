program define varscontr5
keep ETIremuneradodocontrato IDRH Nºdehorasdedocênciado1ºsem Unidademedidahorasdocência Nomecompleto Subsistemadeensino Códigoestabelecimento Estabelecimento Códigounidadeorgânica Unidadeorgânica Categoria Regimedeprestaçãodeserviço

rename IDRH idrh
rename ETIremuneradodocontrato Perc_Parc_Reg 
rename Nºdehorasdedocênciado1ºsem Classhours 
rename Unidademedidahorasdocência Unit_Classhours
rename Nomecompleto Name
rename Códigoestabelecimento Establishment_Code
rename Subsistemadeensino Teaching_subsystem
rename Estabelecimento Establishment
rename Unidadeorgânica Organic_Unit
rename Categoria Categ
rename Códigounidadeorgânica Organic_Unit_Code
rename Regimedeprestaçãodeserviço Prest_Reg

foreach var of varlist _all {
	label var `var' ""
}

tostring Organic_Unit_Code, replace
replace Organic_Unit_Code = substr(Organic_Unit_Code, 2, 4)

//We do this, for now, without standardizing the text, but we correct possible errors later on.
gen Guest = 1 if regexm(Categ, "Convidado")
replace Guest = 1 if regexm(Categ, "convidado")
replace Guest = 0 if Guest == . 

replace Perc_Parc_Reg = Perc_Parc_Reg*100

end



