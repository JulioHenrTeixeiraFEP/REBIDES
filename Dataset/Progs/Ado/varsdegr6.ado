program define varsdegr6

keep Nome Grau NumDocente
rename Grau Degree
rename Nome Name
rename NumDocente numdocente

foreach var of varlist _all {
	label var `var' ""
}
end