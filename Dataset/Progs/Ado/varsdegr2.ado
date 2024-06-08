program define varsdegr2
keep Nomecompleto Grau IDDOcente
rename Nomecompleto Name
rename Grau Degree
rename IDDOcente iddocente

foreach var of varlist _all {
	label var `var' ""
}
end