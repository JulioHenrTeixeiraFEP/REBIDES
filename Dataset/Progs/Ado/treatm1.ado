program define treatm1

//Treating the missing information...
replace Degree_Year = "." if Degree_Year == ""
replace Degree_Country_Code = "." if  Degree_Country_Code == ""
replace CNAEF_area = "." if  CNAEF_area == ""

// if we want to get the general CNAEF areas using only the data given by the data set (we can only do this for 2019, 2020, 2021 and 2022), with CITE-2013 as a base.
destring CNAEF_area, replace
gen GenArea = ""
replace GenArea = "Generic programs and qualifications" if 0<=CNAEF_area<100
replace GenArea = "Education" if CNAEF_area>=100 & CNAEF_area<200
replace GenArea = "Arts and humanities" if CNAEF_area>=200 & CNAEF_area<300
replace GenArea = "Social sciences, journalism and information" if CNAEF_area>=300 & CNAEF_area<400
replace GenArea = "Business sciences, administration and law" if CNAEF_area>=400 & CNAEF_area<500
replace GenArea = "Natural sciences, mathematics and statistics" if CNAEF_area>=500 & CNAEF_area<600
replace GenArea = "Information and communication technologies (ICTs)" if CNAEF_area>=600 & CNAEF_area<700
replace GenArea = "Engineering, manufacturing and construction industries" if CNAEF_area>=700 & CNAEF_area<800
replace GenArea = "Agriculture, forestry, fisheries and veterinary sciences" if CNAEF_area>=800 & CNAEF_area<900
replace GenArea = "Health and social protection" if CNAEF_area>=900 & CNAEF_area<1000
replace GenArea = "Services" if CNAEF_area>=1000 & CNAEF_area<9999
replace GenArea = "Unknown area" if CNAEF_area>=9999

//We standardize its information
standardizetext GenArea, specialchars upper gen(GenArea1)
drop GenArea
rename GenArea1 GenArea


end