program define varsdegr1
keep Nomecompleto Habilitaçãomaiselevada IDRH

rename IDRH idrh
rename Nomecompleto Name
rename Habilitaçãomaiselevada Degree
foreach var of varlist _all {
	label var `var' ""
}
end