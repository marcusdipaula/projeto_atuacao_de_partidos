let
    Fonte = Json.Document(Web.Contents("https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome")),
    dados = Fonte[dados],
    #"Convertido para Tabela" = Table.FromList(dados, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Column1 Expandido" = Table.ExpandRecordColumn(#"Convertido para Tabela", "Column1", {"id", "uri", "nome", "siglaPartido", "uriPartido", "siglaUf", "idLegislatura", "urlFoto"}, {"Column1.id", "Column1.uri", "Column1.nome", "Column1.siglaPartido", "Column1.uriPartido", "Column1.siglaUf", "Column1.idLegislatura", "Column1.urlFoto"}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Column1 Expandido",{{"Column1.nome", "Parlamentar"}, {"Column1.siglaPartido", "Partido"}, {"Column1.siglaUf", "UF"}}),
    #"Valor Substituído" = Table.ReplaceValue(#"Colunas Renomeadas","CHICO D'ANGELO","CHICO D`ANGELO",Replacer.ReplaceText,{"Parlamentar"}),
    #"Valor Substituído1" = Table.ReplaceValue(#"Valor Substituído","DA VITORIA","DA VITÓRIA",Replacer.ReplaceText,{"Parlamentar"}),
    #"Valor Substituído2" = Table.ReplaceValue(#"Valor Substituído1","FLAVIO NOGUEIRA","FLÁVIO NOGUEIRA",Replacer.ReplaceText,{"Parlamentar"}),
    #"Valor Substituído3" = Table.ReplaceValue(#"Valor Substituído2","JOSÉ AIRTON FÉLIX CIRILO","JOSÉ AIRTON CIRILO",Replacer.ReplaceText,{"Parlamentar"}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Valor Substituído3",{"Column1.uri"}),
    #"Colunas Renomeadas1" = Table.RenameColumns(#"Colunas Removidas",{{"Column1.id", "ID_Parlamentar"}, {"Column1.urlFoto", "URL_foto"}, {"Column1.idLegislatura", "ID_Legislatura"}, {"Column1.uriPartido", "URL_partido"}})
in
    #"Colunas Renomeadas1"