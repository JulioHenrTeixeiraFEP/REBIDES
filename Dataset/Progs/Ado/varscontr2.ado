program define varscontr2
//The Excel pages for public and private HEI have different variable names. Thus, there was a need for another program definition.
keep Unidadehorasletivas Horasletivas doregimeparcial Convidado IDDOcente Nomecompleto Subsistemaensino Códigoestabelecimento Estabelecimento Códigounidadeorgânica Unidadeorgânica Categoria Regimedeprestaçãodeserviço

rename IDDOcente iddocente
rename doregimeparcial Perc_Parc_Reg 
rename Horasletivas Classhours 
rename Unidadehorasletivas Unit_Classhours
rename Convidado Guest
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