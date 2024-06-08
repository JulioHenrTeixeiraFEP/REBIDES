//////////////////////////////////////////////////////////////////////////////////////////////
//title: Establishments_Location_Tidy
//author: Júlio Teixeira
//date: 09/02/2024
//objective: to take a database that has the location of each of the higher education institutions in Portugal, process it and prepare it so that it can be used together with the main data.
clear all
capture log close
set more off
*version 18

//////////////////////////////////////////////
//Define the main path
global path1 "C:\Users\julio\Desktop\Dataset"
//////////////////////////////////////////////

*Step 1: Change working directory
cd "${path1}"

log using "./Logs/Establishments_Location", replace

//program: Establishments_Location.do

*Step 2: Import the excel data "DGEEC_DSEE_DEES_Estabelecimentos" 
import excel "C:\Users\julio\Desktop\Dataset\Source\DGEEC_DSEE_DEES_Estabelecimentos.xlsx", sheet("Estab. de ensino superior") firstrow clear


*Step 3: Data cleaning
drop Telefone Outrotelefone CódigoPostal Email Website TipodeEnsino Morada Dependede UnidadeOrgânica //We ignore non-relevant information, so as not to "pollute" the dataset too much

order CódigodoEstabelecimento  CódigodaUnidadeOrgânica  Distrito Concelho

//In order to add cases that were not available in the dataset (using information from the HEIs websites):
set obs 362
replace CódigodoEstabelecimento = "0400" in 323/327 // for Universidade da Beira Interior
replace CódigodoEstabelecimento = "1000" in 328/337 // for Universidade do Minho
replace CódigodoEstabelecimento = "2800" in 338 // for Universidade Lusófona de Humanidades e Tecnologias
replace CódigodoEstabelecimento = "4032" in 339 // for Universidade Lusófona do Porto
replace CódigodoEstabelecimento = "4261" in 340 // for Instituto Universitário de Ciências da Saúde
replace CódigodaUnidadeOrgânica = "0401" in 323
replace CódigodaUnidadeOrgânica = "0402" in 324
replace CódigodaUnidadeOrgânica = "0403" in 325
replace CódigodaUnidadeOrgânica = "0404" in 326
replace CódigodaUnidadeOrgânica = "0405" in 327
replace CódigodaUnidadeOrgânica = "1001" in 328
replace CódigodaUnidadeOrgânica = "1002" in 329
replace CódigodaUnidadeOrgânica = "1003" in 330
replace CódigodaUnidadeOrgânica = "1004" in 331
replace CódigodaUnidadeOrgânica = "1005" in 332
replace CódigodaUnidadeOrgânica = "1006" in 333
replace CódigodaUnidadeOrgânica = "1007" in 334
replace CódigodaUnidadeOrgânica = "1008" in 335
replace CódigodaUnidadeOrgânica = "1009" in 336
replace CódigodaUnidadeOrgânica = "1010" in 337
replace CódigodaUnidadeOrgânica = "2800" in 338
replace CódigodaUnidadeOrgânica = "4032" in 339 
replace CódigodaUnidadeOrgânica = "4261" in 340 


replace Distrito = "Lisboa" in 338
replace Concelho = "Lisboa" in 338

replace Distrito = "Porto" in 339
replace Concelho = "Porto" in 339

replace Concelho = "Paredes" in 340
replace Distrito = "Porto" in 340

replace Concelho = "Braga" in 331/337
replace Concelho = "Braga" in 329
replace Concelho = "Guimarães" in 328
replace Concelho = "Guimarães" in 330
replace Distrito = "Braga" in 328/337

replace Distrito = "Covilhã" in 323/327
replace Concelho = "Covilhã" in 323/327



//In order to avoid potential problems with spacing and special characters within place names, we apply this methodology:
standardizetext Distrito, gen(District) upper specialchars
drop Distrito 
standardizetext Concelho, gen(Municipality) upper specialchars
drop Concelho 


//To make sure that the command replaced all special characters:
ssc install chartab, replace 
chartab District, noascii
chartab Municipality, noascii

//To better identify which variables are involved:
rename CódigodoEstabelecimento Establishment_Code
rename CódigodaUnidadeOrgânica Organic_Unit_Code

label var Establishment_Code "Higher education institution identifier code"
label var Organic_Unit_Code "Organic unit identifier code"
label var District "Institution location district"
label var Municipality "Institution location municipality"


// We use the file "V05217_Comp_NUTS2_2024_Munic.xlsx" to obtain the latest classification of municipalities into regions:
gen NUTS2 = "NORTE"

replace NUTS2 = "CENTRO" if Municipality == "AGUEDA" | Municipality == "AVEIRO" | Municipality == "CASTELO BRANCO" | Municipality == "COIMBRA" | Municipality == "COVILHA" | Municipality == "GUARDA" | Municipality == "IDANHA A NOVA" |  Municipality == "LEIRIA" |  Municipality == "MARINHA GRANDE" |  Municipality == "OLIVEIRA DO HOSPITAL" | Municipality == "SEIA" | Municipality == "VISEU"

replace NUTS2 = "ALENTEJO" if Municipality == "BEJA" | Municipality == "ELVAS" | Municipality == "PORTALEGRE" | Municipality == "EVORA"

replace NUTS2 = "PENINSULA DE SETUBAL" if Municipality == "SETUBAL" | Municipality == "ALMADA" | Municipality == "BARREIRO"

replace NUTS2 = "GRANDE LISBOA" if Municipality == "AMADORA" | Municipality == "CASCAIS" | Municipality == "LISBOA" | Municipality == "ODIVELAS" | Municipality == "OEIRAS" | Municipality == "SINTRA"

replace NUTS2 = "OESTE E VALE DO TEJO" if Municipality == "ABRANTES" | Municipality == "CALDAS DA RAINHA" | Municipality == "PENICHE" | Municipality == "RIO MAIOR" | Municipality == "SANTAREM" | Municipality == "TOMAR" | Municipality == "TORRES VEDRAS"

replace NUTS2 = "ALGARVE" if District == "FARO" | Municipality == "PORTIMAO" | Municipality == "SILVES"

replace NUTS2 = "REGIAO AUTONOMA DOS ACORES" if Municipality == "ANGRA DO HEROISMO" | Municipality == "PONTA DELGADA"

replace NUTS2 = "REGIAO AUTONOMA DA MADEIRA" if Municipality == "FUNCHAL"

label var NUTS2 "NUTS II Location Identification" //We add a label to the variable

// Some more adds
replace Establishment_Code = "0100" in 341
replace Establishment_Code = "2200" in 342/344
replace Establishment_Code = "2405" in 345/346
replace Establishment_Code = "2750" in 347/348
replace Establishment_Code = "4005" in 349
replace Establishment_Code = "4011" in 350
replace Establishment_Code = "4025" in 351
replace Establishment_Code = "4074" in 352
replace Establishment_Code = "4078" in 353
replace Establishment_Code = "4093" in 354
replace Establishment_Code = "4101" in 355
replace Establishment_Code = "4150" in 356
replace Establishment_Code = "4354" in 357
replace Establishment_Code = "4358" in 358
replace Establishment_Code = "4385" in 359
replace Establishment_Code = "4440" in 360
replace Establishment_Code = "4531" in 361
replace Establishment_Code = "4380" in 362



replace Organic_Unit_Code = "7097" in 341
replace Organic_Unit_Code = "2215" in 342
replace Organic_Unit_Code = "2216" in 343
replace Organic_Unit_Code = "2225" in 344
replace Organic_Unit_Code = "2403" in 345
replace Organic_Unit_Code = "2404" in 346
replace Organic_Unit_Code = "2752" in 347
replace Organic_Unit_Code = "2753" in 348
replace Organic_Unit_Code = "4005" in 349
replace Organic_Unit_Code = "4011" in 350
replace Organic_Unit_Code = "4025" in 351
replace Organic_Unit_Code = "4074" in 352
replace Organic_Unit_Code = "4078" in 353
replace Organic_Unit_Code = "4093" in 354
replace Organic_Unit_Code = "4101" in 355
replace Organic_Unit_Code = "4150" in 356
replace Organic_Unit_Code = "4354" in 357
replace Organic_Unit_Code = "4358" in 358
replace Organic_Unit_Code = "4385" in 359
replace Organic_Unit_Code = "4441" in 360
replace Organic_Unit_Code = "4531" in 361
replace Organic_Unit_Code = "4380" in 362




replace District = "ILHA DE SAO MIGUEL" in 341
replace Municipality = "VILA NOVA DE FAMALICAO" in 346
replace District = "PORTO" in 345
replace District = "VISEU" in 344
replace District = "PORTO" in 343
replace District = "LISBOA" in 342
replace District = "BRAGA" in 346
replace District = "BRAGA" in 350
replace District = "PORTO" in 347
replace District = "VIANA DO CASTELO" in 348
replace District = "PORTO" in 349
replace District = "VIANA DO CASTELO" in 351
replace District = "LISBOA" in 352
replace District = "PORTO" in 353
replace District = "VILA REAL" in 354
replace District = "PORTO" in 355
replace District = "LISBOA" in 356
replace District = "LEIRIA" in 357
replace District = "PORTO" in 358
replace District = "LISBOA" in 359
replace Municipality = "TORRES VEDRAS" in 359
replace District = "PORTO" in 360
replace District = "PORTO" in 361
replace District = "AVEIRO" in 362



replace NUTS2 = "GRANDE LISBOA" in 342
replace NUTS2 = "NORTE" in 343
replace NUTS2 = "NORTE" in 345/346
replace NUTS2 = "CENTRO" in 344
replace NUTS2 = "REGIAO AUTONOMA DOS ACORES" in 341
replace NUTS2 = "NORTE" in 350
replace NUTS2 = "NORTE" in 347
replace NUTS2 = "NORTE" in 348
replace NUTS2 = "NORTE" in 349
replace NUTS2 = "NORTE" in 351
replace NUTS2 = "GRANDE LISBOA" in 352
replace NUTS2 = "NORTE" in 353
replace NUTS2 = "NORTE" in 354
replace NUTS2 = "NORTE" in 355
replace NUTS2 = "GRANDE LISBOA" in 356
replace NUTS2 = "CENTRO" in 357
replace NUTS2 = "NORTE" in 358
replace NUTS2 = "OESTE E VALE DO TEJO" in 359
replace NUTS2 = "NORTE" in 360
replace NUTS2 = "NORTE" in 361
replace NUTS2 = "NORTE" in 362

replace Establishment_Code = "2405" if Establishment_Code =="2400" & (NUTS == "NORTE")

//A final touch to ensure the organization of information and efficiency when it comes to storage:
compress
sort Establishment_Code

save ".\Data\Establishments_Location_Tidy", replace

log close
