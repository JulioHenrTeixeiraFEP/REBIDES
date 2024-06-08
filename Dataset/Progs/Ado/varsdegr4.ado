program define varsdegr4
keep Nome_docente IDDOcente  Grau_nome 

rename IDDOcente iddocente
rename Nome_docente Name
rename Grau_nome Degree

foreach var of varlist _all {
	label var `var' ""
}
end