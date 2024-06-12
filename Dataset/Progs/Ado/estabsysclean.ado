program define estabsysclean

//This file is responsible for processing the establishment and education subsystem codes that will be used in our study.
//When analyzing the databases, we initially noticed two problems: the subsystems used to be called differently; there are establishments that disappear before the end of the 22 years.
//The first problem can be solved, in part, easily. In fact, previously, the division was not only between universities and polytechnics, but in most cases it was still easy to understand what the classes referred to, either because they had "university" or "polytechnic" in their name. The Catholic University is another case which, although it's not obvious, because the establishment can be either a university or a polytechnic, can be solved through the name of the organic unit. The problem only arises when it comes to "other establishments". In this case, the solution was based on going back to 2005, the year in which this classification ceased to exist, and looking directly at what classification the establishment had in that year. If this is not possible, because for some reason it disappears from the dataset between 2001/2004, we base the classification on the type of professional category the institution had. So an institution with adjunct professors will be a polytechnic, etc.
//The second problem is more complex. In fact, if we weren't going to carry out a mobility study, it could easily be ignored, not least because it wouldn't affect a descriptive analysis at all. The point is that if we don't take this into account, and given that we've decided to use establishment codes as "mobility markers", we'll end up in a situation where, if an establishment is absorbed by another for some reason, but continues to exist and carry on the same activity as it always has, just under a different code and name, we'll be getting "false positives" of mobility. The solution we adopted was to carry out a survey of all the establishments that had disappeared from the dataset, in order to try to understand why this happened. 
//What we decided to do this time was to accommodate code changes when they occur, and do nothing when they don't occur. What this means is that, basically, if two establishments of the same parent company have different establishment codes, they will remain so and so will the mobility analysis. On the other hand, if one establishment is absorbed by another and disappears from the dataset, we consider that the two have the same code. The same applies if two establishments merge or integrate. 
//Although this may have its limitations, we believe it is still a fairly decent solution to the problem. In all cases except one, we prioritize the historical evolution of the codes: in 2022, Universidade Lusíada merged its North and Lisbon hubs into a single code, but in this case we decided not to perform the normalization. We believe that, given the distance between the 2 poles, and the fact that the change was only made in the last year available in the dataset, there is no reason to standardize the codes for the 2 establishments. Therefore, if there is mobility between the 2, this will be taken into account.

//We save the original codes here.
gen ORIGINAL_ESTAB_COD = Establishment_Code
//Correcting missing information in the Excel...
replace Teaching_subsystem = "PUBLIC UNIVERSITY HIGHER EDUCATION" if Establishment == "UNIVERSIDADE NOVA DE LISBOA" & Teaching_subsystem == "" 
gen ORIGINAL_TEACH_SUB = Teaching_subsystem
gen ORIGINAL_ORG_UNIT_CODE = Organic_Unit_Code

//Here we deal directly with the most dubious classifications (mainly due to the problem that the teaching subsystem presented is not objective).
replace Teaching_subsystem = "PRIVATE POLYTECHNIC HIGHER EDUCATION" if (Establishment_Code == "4002" | Establishment_Code == "4005" | Establishment_Code == "4011" | Establishment_Code == "4068" | Establishment_Code == "4069" | Establishment_Code == "4074" | Establishment_Code == "4076" | Establishment_Code == "4077" | Establishment_Code == "4078" | Establishment_Code == "4079" | Establishment_Code == "4081" | Establishment_Code == "4085" | Establishment_Code == "4089" | Establishment_Code == "4090" | Establishment_Code == "4091"| Establishment_Code == "4092" | Establishment_Code == "4093"| Establishment_Code == "4094"| Establishment_Code == "4095"| Establishment_Code == "4096"| Establishment_Code == "4097"| Establishment_Code == "4098"| Establishment_Code == "4099"| Establishment_Code == "4100" | Establishment_Code == "4101" | Establishment_Code == "4102" | Establishment_Code == "4103" | Establishment_Code == "4104" | Establishment_Code == "4105" | Establishment_Code == "4106" | Establishment_Code == "4107" | Establishment_Code == "4115" | Establishment_Code == "4125" | Establishment_Code == "4127" | Establishment_Code == "4155" | Establishment_Code == "4156"| Establishment_Code == "4141"| Establishment_Code == "4157"| Establishment_Code == "4159"| Establishment_Code == "4160"| Establishment_Code == "4200"| Establishment_Code == "4220"| Establishment_Code == "4250"| Establishment_Code == "4283"| Establishment_Code == "4280" | Establishment_Code == "4170" | Establishment_Code == "4270" | Establishment_Code == "4271" | Establishment_Code == "4272"| Establishment_Code == "4277" | Establishment_Code == "4298" | Establishment_Code == "4303" | Establishment_Code == "4305" | Establishment_Code == "4310" | Establishment_Code == "4312" | Establishment_Code == "4361" | Establishment_Code == "4363" | Establishment_Code == "4364" | Establishment_Code == "4425" | Establishment_Code == "4440" | Establishment_Code == "4530" | Establishment_Code == "4380" | Establishment_Code == "4460" | Establishment_Code == "4531" | Establishment_Code == "4365" | Establishment_Code == "4436" | Establishment_Code == "4545" | Establishment_Code == "4362" | Establishment_Code == "4065" | Organic_Unit_Code == "2752" | Organic_Unit_Code == "2753" | Organic_Unit_Code == "2701" | Establishment_Code== "4292" | Organic_Unit_Code== "4092" | Establishment_Code == "4080" | Establishment_Code=="4314") & Teaching_subsystem == "ENSINO SUPERIOR PARTICULAR E COOPERATIVO OUTROS ESTABELECIMENTOS"

replace Teaching_subsystem = "PRIVATE UNIVERSITY HIGHER EDUCATION" if (Establishment_Code == "4520" | Establishment_Code == "4511" | Establishment_Code == "4451" | Establishment_Code == "4510" | Establishment_Code == "4150" | Establishment_Code == "4353" | Establishment_Code == "4050" | Establishment_Code == "4020" | Establishment_Code == "4351" | Establishment_Code == "4010" | Establishment_Code == "4120" | Establishment_Code == "4033" | Establishment_Code == "4031" | Establishment_Code == "4111" | Establishment_Code == "4112" | Establishment_Code == "4025" | Establishment_Code == "4255" | Establishment_Code == "4290" | Establishment_Code == "4358" | Establishment_Code == "4295" | Establishment_Code == "4299" | Establishment_Code == "4306" | Establishment_Code == "4300" | Establishment_Code == "4308" | Establishment_Code == "4307" | Establishment_Code == "4500" | Establishment_Code == "4375" | Organic_Unit_Code == "4126" | Organic_Unit_Code == "4260" | Organic_Unit_Code == "4261" | Establishment_Code == "4350" | Establishment_Code == "4450" | Establishment_Code == "4375"  | Establishment_Code == "4550" | Establishment_Code== "4551" | Establishment_Code == "4309" | Establishment_Code == "4354" | Establishment_Code == "4352") & Teaching_subsystem == "ENSINO SUPERIOR PARTICULAR E COOPERATIVO OUTROS ESTABELECIMENTOS"

//Explaining in more depth, basically, when processing the data, we noticed that there are some establishments that disappear from the dataset. This could represent mergers with integrations of establishments, thus “false positives” of mobility. Therefore, whenever we notice that an establishment code disappears from the dataset, we proceed to research what happened to it. Table A1 of the dissertation summarizes this research. We use the last code that appears in the dataset for that establishment as the universal code for establishments, in cases of absorption or integration.
//The first and perhaps most obvious case of a change in codes was in nursing schools. Both Coimbra, Lisbon and Porto initially had health schools (health technology and nursing) concentrated under the code Polytechnic Health Institute (2001) and after that, they began to appear autonomously in the dataset, due to the aggregation of nursing schools in each of the cities. So, following the movement of the codes that took place, we decided to separate this institute in the same way as will happen in the future, in the initial year, when we have this problem. On the one hand, we grouped the nursing schools into an autonomous group, and on the other, we added the health technology schools to the polytechnics. 
//Although Decreto-Lei n.º 99/2001 is used as the basis for this transformation, the decree that follows ends up "cancelling" some of these changes, so we decided to apply both at the same time to avoid complications.

//Decreto-Lei n.º 175/2004 shows evidence on health institutions
//Firstly, all nursing schools inside of Lisbon, Porto and Coimbra, separately, merged
//In Porto, ESCOLA SUPERIOR DE ENFERMAGEM CIDADE DO PORTO, ESCOLA SUPERIOR DE ENFERMAGEM DE D ANA GUEDES, and ESCOLA SUPERIOR DE ENFERMAGEM DE SAO JOAO merged into ESCOLA SUPERIOR DE ENFERMAGEM DO PORTO
replace Establishment_Code = "7003" if Establishment_Code=="7060" | Establishment_Code == "7062" | Establishment_Code == "7061" | Organic_Unit_Code == "7061" | Organic_Unit_Code == "7060" | Organic_Unit_Code == "7062"
//In Coimbra, ESCOLA SUPERIOR DE ENFERMAGEM DO DR ANGELO DA FONSECA and ESCOLA SUPERIOR DE ENFERMAGEM DE BISSAYA BARRETO merged into ESCOLA SUPERIOR DE ENFERMAGEM DE COIMBRA
replace Establishment_Code = "7001" if Establishment_Code == "7026" | Establishment_Code == "7025" | Organic_Unit_Code == "7025" | Organic_Unit_Code == "7026"
//In Lisboa, ESCOLA SUPERIOR DE ENFERMAGEM DE ARTUR RAVARA, ESCOLA SUPERIOR DE ENFERMAGEM DE FRANCISCO GENTIL, ESCOLA SUPERIOR DE ENFERMAGEM DE MARIA FERNANDA RESENDE, and ESCOLA SUPERIOR DE ENFERMAGEM DE CALOUSTE GULBENKIAN DE LISBOA merged into ESCOLA SUPERIOR DE ENFERMAGEM DE LISBOA
replace Establishment_Code = "7002" if Establishment_Code == "7050" | Establishment_Code == "7053" | Establishment_Code == "7052" | Establishment_Code == "7051" | Organic_Unit_Code == "7050" | Organic_Unit_Code == "7051" | Organic_Unit_Code == "7053" | Organic_Unit_Code == "7052"

//Secondly, we have the integration of the Higher Schools of Health Technology into the polytechnics of each of the 3 cities

//ESCOLA SUPERIOR DE TECNOLOGIA DA SAUDE DE COIMBRA into INSTITUTO POLITECNICO DE COIMBRA
replace Establishment_Code = "3060" if Organic_Unit_Code == "7210" 
//ESCOLA SUPERIOR DE TECNOLOGIA DA SAUDE DO PORTO into INSTITUTO POLITECNICO DO PORTO
replace Establishment_Code = "3130" if Organic_Unit_Code == "7230" 
//ESCOLA SUPERIOR DE TECNOLOGIA DA SAUDE DE LISBOA into INSTITUTO POLITECNICO DE LISBOA
replace Establishment_Code = "3110" if Organic_Unit_Code == "7220" 


//Thirdly, we have integrations of nursing schools into universities in some cities.
//ESCOLA SUPERIOR DE ENFERMAGEM DE VILA REAL became part of UTAD
replace Establishment_Code = "1200" if Establishment_Code == "7080"
//ESCOLA SUPERIOR DE ENFERMAGEM DE SAO JOAO DE DEUS became part of U EVORA
replace Establishment_Code = "0600" if Establishment_Code == "7030"
//ESCOLA SUPERIOR DE ENFERMAGEM DE CALOUSTE GULBENKIAN became part of U MINHO
replace Establishment_Code = "1000" if Establishment_Code == "7010"
//ESCOLA SUPERIOR DE ENFERMAGEM DE ANGRA DO HEROISMO and ESCOLA SUPERIOR DE ENFERMAGEM DE PONTA DELGADA became part of U ACORES
replace Establishment_Code = "0100" if Establishment_Code == "7090" | Establishment_Code == "7091"
//ESCOLA SUPERIOR DE ENFERMAGEM DA MADEIRA became part of U MADEIRA
replace Establishment_Code = "1300" if Establishment_Code == "7095"

//Decreto-Lei n.º 99/2001: there was a major reorganization of the higher education system in the health area in 2001, with the polytechnic health institutes of Coimbra, Lisbon and Porto integrating the various schools linked to medicine. Given that the changes are similar to those presented in Decreto-Lei n.º 175/2004, and that initially there were no significant changes to the establishments’ codes, we decided not to include this document in the table (as it would not add much information). In any case, Decreto-Lei n.º 99/2001 placed the health schools in each of the three cities integrated into the polytechnic health institutes, which is taken into account in the data processing. We integrated them into the polytechnics of the three cities to avoid “false positives”.		

//Some extra cases:
//Decreto-Lei n.º 266-E/2012: The TECNICA DE LISBOA and U LISBOA merged into one during the analysis period, so to facilitate the mobility study, we placed both establishments with the new code from the beginning.
replace Establishment_Code = "1500" if Establishment_Code=="0700" | Establishment_Code =="0800"

//Decreto-Lei n.º 194/2004: ISMAG and ISHT PORTIMAO (poli) fused into INSTITUTO SUPERIOR MANUEL TEIXEIRA GOMES
replace Establishment_Code = "4375" if Establishment_Code == "4314" | Establishment_Code == "4365"

//In this specific case, we did not find legislation that proved that the connection between the establishments occurred. Even so, we decided to proceed with homogenization. We consider this to be the best possible solution. According to the news "https://www.publico.pt/2007/03/20/portugal/noticia/instituto-superior-de-servico-social-de-beja-fecha-em-2008 -devido-a- lack of students-1288877", the 2 centres, Lisbon and Beja, were made part of the pedagogical and scientific structure of Universidade Lusíada in 2006. This served as the basis of our decision. Therefore, we placed the codes of the INSTITUTO SUPERIOR DE SERVICO SOCIAL DE LISBOA and the INSTITUTO SUPERIOR DE SERVICO SOCIAL DE LISBOA BEJA, as the same as the UNIVERSIDADE LUSIADA DE LISBOA, to avoid any false mobility that could be confused (particularly when it comes to professors continued to work in the same place, but with different codes).
//----------: INSTITUTO SUPERIOR DE SERVICO SOCIAL DE LISBOA "integrated" U LUSIADA in 2007.
replace Establishment_Code = "2400" if Establishment_Code == "4510" | Establishment_Code == "4511" 

//----------: ESCOLA SUPERIOR DE ENFERMAGEM DA IMACULADA CONCEICAO and ESCOLA SUPERIOR DE ENFERMAGEM DE S VICENTE DE PAULO became part of UC
replace Establishment_Code = "2200" if Establishment_Code == "4092" | Establishment_Code == "4094"

//Decreto-Lei n.º 56/2005: INSTITUTO SUPERIOR DE HUMANIDADES E TECNOLOGIAS MARINHA GRANDE and INSTITUTO SUPERIOR DE MATEMATICA E GESTAO MARINHA GRANDE became INSTITUTO SUPERIOR D DINIS
replace Establishment_Code = "4292" if Establishment_Code == "4312" | Establishment_Code == "4361"

//Decreto-Lei n.º 61/2021: INSTITUTO SUPERIOR DE TECNOLOGIAS AVANCADAS DE LISBOA PORTO is the same as INSTITUTO SUPERIOR DE TECNOLOGIAS AVANCADAS DE PORTO
replace Establishment_Code = "4640" if Establishment_Code == "4531"

//Decreto-Lei n.º 61/2021: U MAIA is the same as INSTITUTO UNIVERSITARIO DA MAIA ISMAI
replace Establishment_Code = "4630" if Establishment_Code == "4358"

//Decreto-Lei n.º 61/2021: INSTITUTO POLITECNICO JEAN PIAGET DO NORTE is the same as ESCOLA SUPERIOR DE SAUDE JEAN PIAGET DE VILA NOVA DE GAIA + Escola Superior de Desporto e Educação Jean Piaget de Vila Nova de Gaia
replace Establishment_Code = "4625" if Establishment_Code == "4101"

//Despacho n.º 2349/2015: U LUSIADA NORTE is the same as U LUSIADA FAMALICÃO + U LUSIADA PORTO
//U LUSIADA changed its codes in 2022. In our study on mobility, we decided to keep the different codes, instead of the homogenization that occurred between HEIs in the north and south, which now have the same identification code at the establishment level.
replace Establishment_Code = "2405" if Establishment_Code == "2401" | Establishment_Code == "2402" | (Establishment_Code == "2400" & NUTS2 == "NORTE")

//Despacho n.º 6006/2016 and Decreto-Lei n.º 4/2019: U ATLANTICA changed codes, but still represents the same, in general. Since the changes that ocurred in the institution were confusing, we decided to simplify and thus chose to place the Escola Superior de Saúde Atlântica with the same establishment code as the Universidade Atlântica, given that if we do not do so, we will have remnants of mobility that in fact did not occur (in practice, the workers continued at the same HEI).
replace Establishment_Code = "2710" if Establishment_Code == "2700" | Establishment_Code == "4590" 

//Decreto-Lei n.º 4/2019: INSTITUTO POLITECNICO JEAN PIAGET DO SUL resulted from the integration of ESCOLA SUPERIOR DE EDUCACAO JEAN PIAGET DE ALMADA, ESCOLA SUPERIOR DE SAUDE JEAN PIAGET ALGARVE e ESCOLA SUPERIOR DE TECNOLOGIA E GESTAO JEAN PIAGET.
replace Establishment_Code = "4600" if Establishment_Code == "4077" | Establishment_Code == "4309" | Establishment_Code == "4102"

//Decreto-Lei n.º 147/2013: ISLA GAIA (ISLA INSTITUTO POLITECNICO DE GESTAO E TECNOLOGIA) came from INSTITUTO SUPERIOR DE LINGUAS E ADMINISTRACAO DE VILA NOVA DE GAIA
replace Establishment_Code = "4570" if Establishment_Code == "4353" 

//Decreto-Lei n.º 206/2012: INSTITUTO DE ARTE DESIGN E EMPRESA UNIVERSITARIO is ESCOLA SUPERIOR DE DESIGN + ESCOLA SUPERIOR DE MARKETING E PUBLICIDADE
replace Establishment_Code = "4560" if Establishment_Code == "4111" | Establishment_Code == "4112" 

//Aviso n.º 15743/2016: INSTITUTO DE ARTE DESIGN E EMPRESA UNIVERSITARIO is now part of U EUROPEIA
replace Establishment_Code = "4350" if Establishment_Code == "4560" 

//Aviso n.º 8572/2006: INSTITUTO SUPERIOR DE CIENCIAS DA ADMINISTRACAO is INSTITUTO SUPERIOR DE HUMANIDADES E TECNOLOGIAS DE LISBOA + INSTITUTO DE ESTUDOS SUPERIORES DE CONTABILIDADE
replace Establishment_Code = "4275" if Establishment_Code == "4127" | Establishment_Code == "4310"

//Decreto-Lei n.º 77/2019: INSTITUTO POLITECNICO DA LUSOFONIA is ESCOLA SUPERIOR DE SAUDE RIBEIRO SANCHES + INSTITUTO SUPERIOR DE CIENCIAS DA ADMINISTRACAO
replace Establishment_Code = "4610" if Establishment_Code == "4104" | Establishment_Code == "4275" 

//Despacho n.º 13624/2010: ESCOLA SUPERIOR DE EDUCACAO DE SANTA MARIA was absorbed by INSTITUTO SUPERIOR POLITECNICO GAYA
replace Establishment_Code = "4440" if Establishment_Code == "4090" 

//Aviso n.º 14027/2019: ESCOLA SUPERIOR DE ENFERMAGEM DR JOSE TIMOTEO MONTALVAO MACHADO changed its denomination to ESCOLA SUPERIOR DE SAUDE CRUZ VERMELHA PORTUGUESA ALTO TAMEGA 
replace Establishment_Code = "4110" if Establishment_Code == "4093" 

//Aviso n.º 3103/2006: INSTITUTO SUPERIOR DE ADMINISTRACAO E GESTAO is INSTITUTO SUPERIOR DE ADMINISTRACAO E GESTAO + INSTITUTO SUPERIOR DE ASSISTENTES E INTERPRETES
replace Establishment_Code = "4200" if Establishment_Code == "4250" | Establishment_Code == "4200" 

//Decreto-Lei n.º 82/2005: INSTITUTO SUPERIOR POLITECNICO DO OESTE is INSTITUTO SUPERIOR DE MATEMATICA E GESTAO TORRES VEDRAS + INSTITUTO SUPERIOR DE HUMANIDADES E TECNOLOGIAS DE LISBOA
replace Establishment_Code = "4385" if Establishment_Code == "4310" | Establishment_Code == "4364" 

//Decreto-lei 45/2020, de 23 de Julho: Escola Superior de Saúde da Fundação "Fernando Pessoa" gains autonomous recognition
replace Establishment_Code = "4620" if Organic_Unit_Code == "2752" 


// Some university names have been standardized, so we can use them more easily, later, in our analysis, separately.
replace Establishment="U LISBOA" if Establishment_Code=="0700" | Establishment_Code == "1500" | Establishment_Code =="0800"


//The data was homogenized because before 2007/2008 the classification of higher education subsystems was different. This can be problematic, especially when we analyze directly the transition of professors between universities and polytechnics, one of our main objectives. 

replace Teaching_subsystem = "PUBLIC UNIVERSITY HIGHER EDUCATION" if Teaching == "ENSINO SUPERIOR PUBLICO UNIVERSITARIO"

replace Teaching_subsystem = "PRIVATE UNIVERSITY HIGHER EDUCATION" if Teaching_subsystem == "UNIVERSIDADE CATOLICA PORTUGUESA" | Teaching_subsystem == "ENSINO SUPERIOR PARTICULAR E COOPERATIVO UNIVERSIDADES" | Teaching_subsystem == "UNIVERSIDADE CATOLICA PORTUGUESA UNIVERSITARIO" | Teaching_subsystem == "ENSINO SUPERIOR PARTICULAR E COOPERATIVO UNIVERSITARIO" | Teaching_subsystem == "ENSINO SUPERIOR PRIVADO UNIVERSITARIO"

replace Teaching_subsystem = "PUBLIC POLYTECHNIC HIGHER EDUCATION" if Teaching_subsystem == "ENSINO SUPERIOR PUBLICO POLITECNICO GERAL" | Teaching_subsystem == "ENSINO SUPERIOR PUBLICO POLITECNICO OUTRAS ESCOLAS" | Teaching_subsystem == "ENSINO SUPERIOR PUBLICO POLITECNICO" 

replace Teaching_subsystem = "PRIVATE POLYTECHNIC HIGHER EDUCATION" if Teaching_subsystem == "ENSINO SUPERIOR PARTICULAR E COOPERATIVO POLITECNICO" | Teaching_subsystem == "UNIVERSIDADE CATOLICA PORTUGUESA POLITECNICO" | Teaching_subsystem == "ENSINO SUPERIOR PRIVADO POLITECNICO" | Organic_Unit== "UNIVERSIDADE CATOLICA PORTUGUESA ESCOLA SUPERIOR POLITECNICA DE SAUDE LISBOA" | Organic_Unit== "UNIVERSIDADE CATOLICA PORTUGUESA ESCOLA SUPERIOR POLITECNICA DE SAUDE PORTO"

replace Teaching_subsystem = "MILITARY AND POLICIAL PUBLIC UNIVERSITY HIGHER EDUCATION" if Teaching_subsystem == "ENSINO SUPERIOR PUBLICO ENSINO MILITAR E POLICIAL U" | Teaching_subsystem == "ENSINO SUPERIOR PUBLICO ENSINO MILITAR E POLICIAL UNIVERSITARIO" | Teaching_subsystem == "ENSINO SUPERIOR PUBLICO MILITAR E POLICIAL UNIVERSITARIO"

replace Teaching_subsystem = "MILITARY AND POLICIAL PUBLIC POLYTECHNIC HIGHER EDUCATION" if Teaching_subsystem == "ENSINO SUPERIOR PUBLICO ENSINO MILITAR E POLICIAL P" | Teaching_subsystem == "ENSINO SUPERIOR PUBLICO ENSINO MILITAR E POLICIAL POLITECNICO" | Teaching_subsystem == "ENSINO SUPERIOR PUBLICO MILITAR E POLICIAL POLITECNICO"


//Now, for some cases of organic unit changes:
destring Organic_Unit_Code, replace
 replace Organic_Unit_Code=1500 if Organic_Unit_Code==700 /* Universidade de Lisboa (UL)*/
 replace Organic_Unit_Code=1503 if Organic_Unit_Code==701 /* UL: Fac. de ciencias*/
 replace Organic_Unit_Code=1504 if Organic_Unit_Code==702 /* UL: Fac. de direito*/
 replace Organic_Unit_Code=1505 if Organic_Unit_Code==703 /* UL: Fac. de farmacia*/
 replace Organic_Unit_Code=1506 if Organic_Unit_Code==704 /* UL: Fac. de letras*/
 replace Organic_Unit_Code=1507 if Organic_Unit_Code==705 /* UL: Fac. de medicina*/
 replace Organic_Unit_Code=1514 if Organic_Unit_Code==708 /* UL: IS Geografia e orden. territorio*/
 replace Organic_Unit_Code=1513 if Organic_Unit_Code==709 /* UL: Inst. Educacao*/
 replace Organic_Unit_Code=1511 if Organic_Unit_Code==710 | Organic_Unit_Code == 706 /* UL: Fac. de psicologia*/
 replace Organic_Unit_Code=1509 if Organic_Unit_Code==801 /* UTL: Fac. de medicina vet.*/
 replace Organic_Unit_Code=1501 if Organic_Unit_Code==802 /* UTL: Fac. de arquitetura*/
 replace Organic_Unit_Code=1515 if Organic_Unit_Code==803 /* UTL: ISA*/
 replace Organic_Unit_Code=1516 if Organic_Unit_Code==804 /* UTL: ISCSP*/
 replace Organic_Unit_Code=1517 if Organic_Unit_Code==805 /* UTL: ISEG*/
 replace Organic_Unit_Code=1510 if Organic_Unit_Code==806 /* UTL: Faculdade de Motrocidade Humana*/
 replace Organic_Unit_Code=1518 if Organic_Unit_Code==807 /* UTL: IST*/
 replace Organic_Unit_Code=1519 if Organic_Unit_Code==808 /* UTL: IST (tagus park)*/
 replace Organic_Unit_Code=1502 if Organic_Unit_Code==5302 /* UL: Faculdade de Belas Artes*/
 replace Organic_Unit_Code=1508 if Organic_Unit_Code==6600 /* UL: Fac. de medicina dentaria*/
 replace Organic_Unit_Code=203  if Organic_Unit_Code==202 /* UALG Fac. Ciências do Mar e AMbiente is now Fac. Ciências e Tecnologia*/
 replace Organic_Unit_Code=203  if Organic_Unit_Code==205 /* UALG Fac. Ciências do Mar e AMbiente is now Fac. Ciências e Tecnologia*/
 ** There was a generic code for the Organic Units (= Establishment_Code). We used the first organic unit (2008-2010 period)
 replace Organic_Unit_Code=601  if Organic_Unit_Code== 600 /* UEvora*/
 replace Organic_Unit_Code=1201 if Organic_Unit_Code== 1200 /* UTAD*/
 replace Organic_Unit_Code=1201 if Organic_Unit_Code== 1290 /* UTAD (chaves)*/
 replace Organic_Unit_Code=3111 if Organic_Unit_Code== 3110 /* IPLisboa*/
 replace Organic_Unit_Code=3131 if Organic_Unit_Code== 3130 /* IPPorto*/
 replace Organic_Unit_Code=4098 if Organic_Unit_Code== 7095 /* ESenf Jose Cluny era ESenf Madeira*/
 replace Organic_Unit_Code=2218 if Organic_Unit_Code==2215 /* UCP politecino saude lisboa is now escola de enfermagem de lisboa (politecnico) */
 replace Organic_Unit_Code=2219 if Organic_Unit_Code==2216 /* UCP politecino saude lisboa is now escola de enfermagem de lisboa (politecnico) */
 replace Organic_Unit_Code=2228 if Organic_Unit_Code==2225/* UCP VISEU (BEIRAS) */
 replace Organic_Unit_Code=2410 if Organic_Unit_Code==2400 /* Ulusiada Lisboa */
 replace Organic_Unit_Code=2440 if Organic_Unit_Code==2403 /* Ulusiada Norte Porto */
 replace Organic_Unit_Code=2450 if Organic_Unit_Code==2404 /* Ulusiada Norte Famalicao */
 replace Organic_Unit_Code=2910 if Organic_Unit_Code==2800 /* Ulusiada Lusófona Lisboa (Humanidades e Tecnologia) */
 replace Organic_Unit_Code=2920 if Organic_Unit_Code==4032 /* Ulusiada Lusófona Porto */
 replace Organic_Unit_Code=4627 if Organic_Unit_Code==4101 /* Piaget educação VNG */
 replace Organic_Unit_Code=4626 if Organic_Unit_Code==4078 /* Piaget Arcozelo */
 replace Organic_Unit_Code=4640 if Organic_Unit_Code==4531
 replace Organic_Unit_Code=4650 if Organic_Unit_Code==4261
 replace Organic_Unit_Code=4630 if Organic_Unit_Code==4358

//Taking the opportunity to homogenize some names that are written differently between datasets...
replace Establishment = "ESCOLA SUPERIOR ARTISTICA DE GUIMARAES" if Establishment == "ESCOLA SUPERIOR ARTISTICA DO PORTO GUIMARAES"
replace Establishment = "ESCOLA SUPERIOR DE EDUCACAO ALMEIDA GARRETT" if Establishment == "ESCOLA SUPERIOR DE EDUCACAO DE ALMEIDA GARRETT"
replace Establishment = "ESCOLA SUPERIOR DE EDUCACAO JEAN PIAGET NORDESTE" if Establishment == "ESCOLA SUPERIOR DE EDUCACAO JEAN PIAGET DE NORDESTE"
replace Establishment = "ESCOLA SUPERIOR DE SAUDE JEAN PIAGET ALGARVE" if Establishment == "ESCOLA SUPERIOR DE SAUDE JEAN PIAGET DE ALGARVE"
replace Establishment = "INSTITUTO SUPERIOR AUTONOMO DE ESTUDOS POLITECNICOS" if Establishment == "INSTITUTO POLITECNICO AUTONOMO"
replace Establishment = "INSTITUTO PORTUGUES DE ADMINISTRACAO DE MARKETING DE AVEIRO" if Establishment == "INSTITUTO PORTUGUES DE ADMINISTRACAO DE MARKETING DE MATOSINHOS AVEIRO"
replace Establishment = "INSTITUTO PORTUGUES DE ADMINISTRACAO DE MARKETING DO PORTO" if Establishment == "INSTITUTO PORTUGUES DE ADMINISTRACAO DE MARKETING DE MATOSINHOS"
replace Establishment = "INSTITUTO UNIVERSITARIO DA MAIA ISMAI" if Establishment == "INSTITUTO SUPERIOR DA MAIA"
replace Establishment = "INSTITUTO POLITECNICO DE SAUDE DO NORTE CESPU" if Establishment == "INSTITUTO POLITECNICO DE SAUDE DO NORTE" | Establishment == "CESPU INSTITUTO POLITECNICO DE SAUDE DO NORTE"
replace Organic_Unit = "INSTITUTO POLITECNICO DE VISEU ESCOLA SUPERIOR DE TECNOLOGIA DE VISEU" if Organic_Unit == "INSTITUTO POLITECNICO DE VISEU ESCOLA SUPERIOR DE TECNOLOGIA E GESTAO DE VISEU"
replace Establishment = "U MAIA" if Establishment == "INSTITUTO UNIVERSITARIO DA MAIA ISMAI" 
replace Establishment = "INSTITUTO SUPERIOR DE ESTUDOS INTERCULTURAIS E TRANSDISCIPLINARES ALMADA" if Establishment == "INSTITUTO SUPERIOR DE ESTUDOS INTERCULTURAIS E TRANSDISCIPLINARES DE ALMADA"

//In order to correctly encode the Teaching_subsystem, we will create a var with the actual codes.
gen Teach_Sub_Code = 110 // PUBLIC UNIVERSITY HIGHER EDUCATION
replace Teach_Sub_Code = 120 if Teaching_subsystem == "PUBLIC POLYTECHNIC HIGHER EDUCATION"
replace Teach_Sub_Code = 210 if Teaching_subsystem == "PRIVATE UNIVERSITY HIGHER EDUCATION"
replace Teach_Sub_Code = 220 if Teaching_subsystem == "PRIVATE POLYTECHNIC HIGHER EDUCATION"
replace Teach_Sub_Code = 131 if Teaching_subsystem == "MILITARY AND POLICIAL PUBLIC UNIVERSITY HIGHER EDUCATION"
replace Teach_Sub_Code = 132 if Teaching_subsystem == "MILITARY AND POLICIAL PUBLIC POLYTECHNIC HIGHER EDUCATION"

//Now we encode the Teaching_subsystem
bpencode Teach_Sub_Code, vl(Teaching_subsystem) gen(Teach_sub)
drop Teaching_subsystem
label var Teach_sub "Type of teaching subsystem"

//Changing the format of string variables to numeric.
destring Establishment_Code, replace

//Adding some additional labels:
label var ORIGINAL_TEACH_SUB "Original teaching subsystem"
label var ORIGINAL_ESTAB_COD "Original establishment code"
label var ORIGINAL_ORG_UNIT_CODE "Original organic unic code"
label var Teach_Sub_Code "Teaching subsystem code"

end
