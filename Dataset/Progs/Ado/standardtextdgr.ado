program define standardtextdgr

standardizetext Degree, specialchars upper gen(Degr)
drop Degree
rename Degr Degree

standardizetext Name, specialchars upper gen(Name1)
drop Name
rename Name1 Name

end