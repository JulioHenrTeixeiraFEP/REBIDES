program define varscontr7

keep UnidadeHL HorasLetivas Convidado RegimeParcial IDDOcente Nome_docente Seccao_Nome Estab Estab_Nome UO UO_Nome1 Categoria_Nome RegimePrestacaoServico_nome

rename IDDOcente iddocente
rename RegimeParcial Perc_Parc_Reg
rename Convidado Guest 
rename HorasLetivas Classhours 
rename UnidadeHL Unit_Classhours 
rename Nome_docente Name
rename Estab Establishment_Code
rename Seccao_Nome Teaching_subsystem
rename Estab_Nome Establishment
rename UO_Nome1 Organic_Unit
rename Categoria_Nome Categ
rename UO Organic_Unit_Code
rename RegimePrestacaoServico_nome Prest_Reg

foreach var of varlist _all {
	label var `var' ""
}
end