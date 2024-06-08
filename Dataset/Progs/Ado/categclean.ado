program define categclean

gen ORIGINAL_Categ = Categ

// We standardized the teaching career categories, following the objectives of our study. Given that, in English, we use the same expressions for equivalent positions between universities and polytechnics, we decided to translate them in the same way.

replace Categ = "ASSOCIATE PROFESSOR" if Categ == "PROFESSOR ASSOCIADO COM AGREGACAO" | Categ == "PROFESSOR ASSOCIADO SEM AGREGACAO" | Categ == "PROFESSOR ASSOCIADO CONVIDADO" | Categ == "DOCENTE UNIVERSITARIO PROFESSOR ASSOCIADO" | Categ == "DOCENTE UNIVERSITARIO PROFESSOR ASSOCIADO CONVIDADO" | Categ == "DOCENTE POLITECNICO PROFESSOR COORDENADOR CONVIDADO" | Categ == "DOCENTE POLITECNICO PROFESSOR COORDENADOR" | Categ == "PROFESSOR COORDENADOR COM AGREGACAO" | Categ == "PROFESSOR COORDENADOR SEM AGREGACAO" | Categ == "PROFESSOR COORDENADOR CONVIDADO" | Categ == "PROFESSOR B" | Categ == "PROFESSOR ASSOCIADO" | Categ == "PROFESSOR COORDENADOR"

replace Categ = "ASSISTANT PROFESSOR" if Categ == "PROFESSOR AUXILIAR COM AGREGACAO" | Categ == "PROFESSOR AUXILIAR SEM AGREGACAO" | Categ == "PROFESSOR AUXILIAR" | Categ == "PROFESSOR AUXILIAR SEM AGREGACAO " | Categ == "PROFESSOR AUXILIAR DO QUADRO TRANSITORIO" | Categ == "PROFESSOR AUXILIAR CONVIDADO" | Categ == "DOCENTE UNIVERSITARIO PROFESSOR AUXILIAR CONVIDADO" | Categ == "DOCENTE UNIVERSITARIO PROFESSOR AUXILIAR" | Categ == "PROFESSOR ADJUNTO CONVIDADO" | Categ == "PROFESSOR ADJUNTO PRINCIPAL" | Categ == "DOCENTE POLITECNICO PROFESSOR ADJUNTO" | Categ == "DOCENTE POLITECNICO PROFESSOR ADJUNTO CONVIDADO" | Categ == "DOCENTE POLITECNICO PROFESSOR ADJUNTO PRINCIPAL CONVIDADO" | Categ == "DOCENTE POLITECNICO PROFESSOR ADJUNTO PRINCIPAL" | Categ == "PROFESSOR C" | Categ == "PROFESSOR ADJUNTO"

replace Categ = "TEACHING ASSISTANT" if Categ == "ASSISTENTE A" | Categ == "ASSISTENTE B" | Categ == "ASSISTENTE DE 1O TRIENIO" | Categ == "ASSISTENTE DE 2O TRIENIO" | Categ == "MESTRE ASSISTENTE" | Categ == "ASSISTENTE DE 2O TRIENIO MESTRE OU DOUTOR" | Categ == "ASSISTENTE DO QUADRO TRANSITORIO" | Categ == "ASSISTENTE CONVIDADO" | Categ == "DOCENTE UNIVERSITARIO ASSISTENTE CONVIDADO" | Categ == "DOCENTE POLITECNICO ASSISTENTE CONVIDADO" | Categ == "DOCENTE POLITECNICO UNIVERSITARIO ASSISTENTE" | Categ == "DOCENTE UNIVERSITARIO ASSISTENTE ESTAGIARIO" | Categ == "DOCENTE POLITECNICO UNIVERSITARIO ASSISTENTE ESTAGIARIO" | Categ == "ASSISTENTE ESTAGIARIO" | Categ == "ASSISTENTE" | regexm(Categ, "MONITOR")

replace Categ = "FULL PROFESSOR" if Categ == "DOCENTE POLITECNICO PROFESSOR COORDENADOR PRINCIPAL CONVIDADO" | Categ == "PROFESSOR CATEDRATICO" | Categ == "PROFESSOR TITULAR" | Categ == "DOCENTE POLITECNICO PROFESSOR COORDENADOR PRINCIPAL" | Categ == "PROFESSOR CATEDRATICO CONVIDADO" | Categ == "DOCENTE UNIVERSITARIO PROFESSOR CATEDRATICO CONVIDADO" | Categ == "DOCENTE UNIVERSITARIO PROFESSOR CATEDRATICO" | Categ == "PROFESSOR A" | Categ == "PROFESSOR COORDENADOR PRINCIPAL"

replace Categ = "RESEARCH POSITIONS" if regexm(Categ, "INVESTIGADOR") | regexm(Categ, "INVESTIGACAO") | regexm(Categ, "BOLSA") | regexm(Categ, "BOLSEIRO")

replace Categ = "MANAGEMENT POSITIONS" if regexm(Categ, "DIRECAO") | regexm(Categ, "DIRECCAO") | regexm(Categ, "PRESIDENTE") | regexm(Categ, "REITOR")

replace Categ = "ICT" if regexm(Categ, "INFORMATICA") | regexm(Categ, "TECNICO DE INFORMATICA")
       
replace Categ = "OTHER" if regexm(Categ, "OUTRAS") | regexm(Categ, "OUTRA") | regexm(Categ, "APOSENTADO") | regexm(Categ, "JUBILADO") | regexm(Categ, "COORDENADOR") | regexm(Categ, "ASSISTENTE OPERACIONAL") | regexm(Categ, "ESTAGIARIO COM LICENCIATURA") | regexm(Categ, "ENSINO BASICO SECUNDARIO") | regexm(Categ, "OUTRAS") | regexm(Categ, "CATEGORIA") | regexm(Categ, "CONTRATOS PARA DOUTORADOS") | regexm(Categ, "ENSINO NAO SUPERIOR") | Categ == "PROFESSOR" | Categ == "CARREIRA TECNICA SUPERIOR" | Categ == "TECNICO SUPERIOR" | Categ == "ASSISTENTE TECNICO" | Categ == "TECNICO PRINCIPAL" | regexm(Categ, "REMUNERACAO") | regexm(Categ, "ENCARREGADO") | regexm(Categ, "LEITOR") | regexm(Categ, "VISITANTE") | regexm(Categ, "COOPERANTE") | regexm(Categ, "COOPERANTE") | regexm(Categ, "COLABORADOR") | Categ == "CONFERENCISTA"

replace Categ = "MILITARY POSITIONS" if regexm(Categ, "OFICIAL") | Categ == "DOCENTE MILITAR"

replace Categ = "MEDICAL POSITIONS" if regexm(Categ, "MEDICO") | regexm(Categ, "ENFERMEIRO") | regexm(Categ, "TECNICO")

//To further generalize our categories...

gen GEN_Categ = Categ

replace GEN_Categ = "OTHER" if Categ == "MEDICAL POSITIONS" | Categ == "MILITARY POSITIONS" | Categ == "OTHERS" | Categ == "ICT" | Categ == "MANAGEMENT POSITIONS" | Categ == "RESEARCH POSITIONS"

//Working links standardization

gen ORIGINAL_Prest_Reg = Prest_Reg

replace Prest_Reg="EXCLUSIVE" if Prest_Reg=="TEMPO INTEGRAL COM DEDICACAO EXCLUSIVA" | Prest_Reg=="REGIME DE TENURE" | Prest_Reg== "DEDICACAO EXCLUSIVA"

replace Prest_Reg="OTHER" if Prest_Reg=="REGIME DE COOPTACAO" | Prest_Reg=="REGIME GRACIOSO" | Prest_Reg=="NAO SE APLICA" | Prest_Reg=="REQUISICAO" | Prest_Reg=="EM REGIME DE COOPTACAO" | Prest_Reg=="3" | Prest_Reg == "CONTRATO DE TRABALHO" | Prest_Reg == "PRESTACAO DE SERVICOS" | Prest_Reg == "OUTRO" | Prest_Reg=="COMISSAO DE SERVICO"

replace Prest_Reg="COLLABORATION" if Prest_Reg=="CONSORCIO DE INSTITUICOES" | Prest_Reg=="COOPERANTE" | Prest_Reg=="COLABORACAO"

replace Prest_Reg = "FULL TIME" if Prest_Reg == "TEMPO INTEGRAL"

replace Prest_Reg = "PART TIME" if Prest_Reg == "TEMPO PARCIAL"

end