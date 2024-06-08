program define varscontr4
keep Nomecompleto Subsistemaensino Códigoestabelecimento Estabelecimento Códigounidadeorgânica Unidadeorgânica Categoria Regimedeprestaçãodeserviço IDDOcente doregimeparcial Convidado Horasletivas Unidadehorasletivas

rename IDDOcente iddocente
rename doregimeparcial Perc_Parc_Reg
rename Convidado Guest 
rename Horasletivas Classhours 
rename Unidadehorasletivas Unit_Classhours 
rename Nomecompleto Name
rename Códigoestabelecimento Establishment_Code
rename Subsistemaensino Teaching_subsystem
rename Estabelecimento Establishment
rename Unidadeorgânica Organic_Unit
rename Categoria Categ
rename Códigounidadeorgânica Organic_Unit_Code
rename Regimedeprestaçãodeserviço Prest_Reg

foreach var of varlist _all {
	label var `var' ""
}
end