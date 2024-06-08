program define varscontr9
keep Nome Regime Códigoestabelecimento Estabelecimento CódigoUnidadeorgânica Unidadeorgânica Categoria Regimedeprestaçãodeserviço Numdocente doRegimeparcial Convidado Horasletivas Unidadedashorasletivas

rename Numdocente numdocente
rename doRegimeparcial Perc_Parc_Reg
rename Convidado Guest 
rename Horasletivas Classhours 
rename Unidadedashorasletivas Unit_Classhours 
rename Nome Name
rename Códigoestabelecimento Establishment_Code
rename Regime Teaching_subsystem
rename Estabelecimento Establishment
rename Unidadeorgânica Organic_Unit
rename Categoria Categ
rename CódigoUnidadeorgânica Organic_Unit_Code
rename Regimedeprestaçãodeserviço Prest_Reg

foreach var of varlist _all {
	label var `var' ""
}
end