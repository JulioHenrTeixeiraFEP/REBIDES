program define hidegr1
//Taking into account that part of the data does not offer us a single variable with the highest qualification of the professor, as would be necessary for our study, we need a way to delete all repeated observations, and leave only the highest grades.
//Furthermore, we standardized the qualification level variables, so that we only have 4 categories.
//We left the 3 main types of qualifications in the data, bringing together all their similar ones, and leaving everything else aside, in the ND category (including the few cases in which it is difficult to discern where to put the diploma).
replace Degree = "MASTER 2 CYCLE" if Degree == "MAGISTER 2 O CICLO DE ESTUDOS" | Degree == "MAGISTER" | Degree == "MASTER" | Degree == "MASTER UNIVERSITARIO" | Degree == "MASTEREXAMEN" | Degree == "MAITRISE" | Degree == "MAGISTER" | Degree == "LAUREA MAGISTRALE" | Degree == "MAGISTRA" | Degree == "LAUREA SPECIALISTICA" | Degree == "CURSO DE MESTRADO CONCLUSAO DO CURSO DE ESPECIALIZACAO" | Degree == "DEA" | Degree == "MAGISTR" | Degree == "MAISTERI" | Degree == "MESTERFOKOZAT" | Degree == "MESTRADO" | Degree == "GRAU DE MESTRE OU EQUIVALENTE OBTIDO NO ESTRANGEIRO" | Degree == "DIPLOME D ETUDES SUPERIEURS" | Degree == "MESTRE"


replace Degree = "DOCTOR 3 CYCLE" if Degree == "DOCTOR PHD" | Degree == "DOCTOR OF PHILOSOPHY" | Degree == "DOCTORAT" | Degree == "DOKTOR TEOLOGIE TH D " | Degree == "DOKTOREXAMEN" | Degree == "DOKTORGRAD" | Degree == "DOTTORATO DI RICERCA" | Degree == "DOCTEUR" | Degree == "FILOSOOFIADOKTOR" | Degree == "TOHTORI" | Degree == "DOCTOR" | Degree == "DOKTOR PHD" |  Degree == "DOKTORI FOKOZAT PHD" | Degree == "DOTTORE DI RICERCA" | Degree == "DOKTOR" | Degree == "DOCTOR OF PHILOSOPHY PHD" | Degree == "CURSO DE DOUTORAMENTO CONCLUSAO DE UNIDADES CURRICULARES" | Degree == "DOUTORADO" | Degree == "POS DOUTORAMENTO"  | Degree == "DOUTORAMENTO" | Degree == "AGREGACAO" | Degree == "GRAU DE DOUTOR OU EQUIVALENTE OBTIDO NO ESTRANGEIRO" | Degree == "DOUTOR" | Degree == "DOKTOR TEOLOGIE TH D"


replace Degree = "BACHELOR 1 CYCLE" if Degree == "LICENCJAT" | Degree == "LICENCE" | Degree == "LAUREA" | Degree == "LICENCIATURA" | Degree == "GRAU DE LICENCIADO OU EQUIVALENTE OBTIDO NO ESTRANGEIRO" | Degree == "LICENCIADO GRAU OBTIDO ANTES DE 2008" | Degree == "LICENCIADO GRAU OBTIDO EM 2008 OU APOS" | Degree == "BACHAREL" | Degree == "BACHELOR 1 O CICLO DE ESTUDOS" | Degree == "BAKALAR" | Degree == "BAKKALAUREA" | Degree == "BACHELOR" | Degree == "BAKKALAUREUS" | Degree == "BAKALAUREUSEKRAAD" | Degree == "BACHARELATO" | Degree == "GRAU DE BACHAREL OU EQUIVALENTE OBTIDO NO ESTRANGEIRO" | Degree == "KANDIDATEXAMAN" | Degree == "KANDIDAATTI" | Degree == "LICENCIADO" | Degree == "DESE"


replace Degree = "ND" if Degree == "OUTROS CURSO DE QUALIFICACAO PROFISSIONAL" | Degree == "OUTROS CURSO MEDIO" | Degree == "OUTROS FREQUENCIA DE ENSINO SUPERIOR" | Degree == "OUTROS NIVEL DE ENSINO NAO SUPERIOR" | Degree == "CURSO DE ESPECIALIZACAO TECNOLOGICA" | Degree == "OUTRO" | Degree == "PROV APT PED CIEN" | Degree == "ENSINO BASICO 2O CICLO 6 O ANO DE ESCOLARIDADE ANTIGA 2 O ANO LICEAL OU CICLO PREPARATORIO" | Degree == "ENSINO BASICO 3O CICLO 9 O ANO DE ESCOLARIDADE ANTIGO 5 O ANO LICEAL OU ENSINO TECNICO" | Degree == "ENSINO BASICO 3O CICLO 9 O ANO DE ESCOLARIDADE ANTIGO 5 O ANO LICEAL OU ENSINO TECNICO" | Degree == "CURSO MEDIO" | Degree == "CURSO TECNICO SUPERIOR PROFISSIONAL" | Degree == "ENSINO BASICO 1O CICLO 4 O ANO DE ESCOLARIDADE ANTIGA 4 A CLASSE" | Degree == "ENSINO SECUNDARIO 12 O ANO DE ESCOLARIDADE OU EQUIVALENTE" | Degree == " ENSINO BASICO 3 O CICLO 9 O ANO DE ESCOLARIDADE ANTIGO 5 O ANO LICEAL OU ENSINO TECNICO" | Degree == "ENSINO BASICO 3 O CICLO 9 O ANO DE ESCOLARIDADE ANTIGO 5 O ANO LICEAL OU ENSINO TECNICO" | Degree == "ENSINO BASICO 1 O CICLO 4 O ANO DE ESCOLARIDADE ANTIGA 4 A CLASSE" | Degree == "ENSINO BASICO 2 O CICLO 6 O ANO DE ESCOLARIDADE ANTIGA 2 O ANO LICEAL OU CICLO PREPARATORIO" | Degree == "DIPLOMA DE POS GRADUACAO" | Degree == "POS GRADUACAO" | Degree == "POSTGRADUATE CERTIFICATE" | Degree == "ESPECIALIZACAO DE POS LICENCIATURA" | Degree == "ESPECIALIZACAO POS BACHARELATO" | Degree == "GRADUADO" | Degree == "COMPLEMENTO DE FORMACAO" | Degree == "DIPLOMA DE ESPECIALIZACAO"

//Now we do this in order to only have, in the end, the highest degree between the four.
gen Highest_Degree = 4
replace Highest_Degree = 3 if Degree == "MASTER 2 CYCLE" 
replace Highest_Degree = 2 if Degree == "BACHELOR 1 CYCLE" 
replace Highest_Degree = 1 if Degree == "ND"

bys idrh iddocente: egen Highest_Degree1 =max(Highest_Degree)
keep if Highest_Degree == Highest_Degree1
drop Highest_Degree Highest_Degree1

//But we can still have the repetition of the same degree.
sort idrh iddocente Degree
quietly by idrh iddocente Degree: gen dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

end