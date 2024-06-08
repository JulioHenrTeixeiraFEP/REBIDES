program define standardtextcontr

standardizetext Teaching_subsystem, specialchars upper gen(Teach_Sub)
drop Teaching_subsystem
rename Teach_Sub Teaching_subsystem

standardizetext Establishment, specialchars upper gen(Estab)
drop Establishment
rename Estab Establishment

standardizetext Organic_Unit, specialchars upper gen(Org_Un)
drop Organic_Unit
rename Org_Un Organic_Unit

standardizetext Prest_Reg, specialchars upper gen(Pr_Reg)
drop Prest_Reg
rename Pr_Reg Prest_Reg

standardizetext Name, specialchars upper gen(Name1)
drop Name
rename Name1 Name

standardizetext Unit_Classhours, specialchars upper gen(Unit_Classhours1)
drop Unit_Classhours
rename Unit_Classhours1 Unit_Classhours

standardizetext Categ, specialchars upper gen(Cat)
drop Categ
rename Cat Categ

end