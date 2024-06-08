program define varsdegr3
keep Nomecompleto Grau IDDocente
rename Nomecompleto Name
rename Grau Degree
rename IDDocente iddocente

foreach var of varlist _all {
	label var `var' ""
}
end