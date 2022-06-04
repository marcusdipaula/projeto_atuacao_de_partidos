let
    Fonte = Json.Document(Web.Contents("https://dadosabertos.camara.leg.br/api/v2/referencias/tiposEvento")),
    dados = Fonte[dados],
    #"Convertido para Tabela" = Table.FromList(dados, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Column1 Expandido" = Table.ExpandRecordColumn(#"Convertido para Tabela", "Column1", {"cod", "sigla", "nome", "descricao"}, {"Column1.cod", "Column1.sigla", "Column1.nome", "Column1.descricao"})
in
    #"Column1 Expandido"