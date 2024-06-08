program define varsdegr5

keep Nome Grau IDdocente
rename Grau Degree
rename Nome Name
rename IDdocente iddocente

foreach var of varlist _all {
	label var `var' ""
}
end