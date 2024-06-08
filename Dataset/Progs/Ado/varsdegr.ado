program define varsdegr
keep IDRH_IEESP IDRH_IECDES Nomecompleto Nívelformação CódigodoPaísdograudiploma AnoGrauDiploma CAreaCNAEFGrauDiploma

rename IDRH_IEESP idrh_ieesp
rename IDRH_IECDES idrh_iecdes  
rename Nomecompleto Name
rename Nívelformação Degree
rename CódigodoPaísdograudiploma Degree_Country_Code
rename AnoGrauDiploma Degree_Year
rename CAreaCNAEFGrauDiploma CNAEF_area

foreach var of varlist _all {
	label var `var' ""
}
end