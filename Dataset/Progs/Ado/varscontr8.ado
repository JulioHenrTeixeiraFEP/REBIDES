program define varscontr8

keep IDdocente Regimeparcial Convidado Horasletivas Unidadehorasletivas Nome Subsistemaensino CódigoEstabelecimentocarreira Estabelecimentocarreira CódigounidadeorgânicaCarreir UnidadeorgânicaCarreira Categoria Regimedeprestaçãodeserviço

rename IDdocente iddocente
rename Regimeparcial Perc_Parc_Reg
rename Convidado Guest 
rename Horasletivas Classhours 
rename Unidadehorasletivas Unit_Classhours 
rename Nome Name
rename CódigoEstabelecimentocarreira Establishment_Code
rename Subsistemaensino Teaching_subsystem
rename Estabelecimentocarreira Establishment
rename UnidadeorgânicaCarreira Organic_Unit
rename Categoria Categ
rename CódigounidadeorgânicaCarreir Organic_Unit_Code
rename Regimedeprestaçãodeserviço Prest_Reg

foreach var of varlist _all {
	label var `var' ""
}
end