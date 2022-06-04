let
    Fonte = Web.Page(Web.Contents("https://www.camara.leg.br/proposicoesWeb/prop_pareceres_substitutivos_votos?idProposicao=2193540")),
    Data0 = Fonte{0}[Data],
    #"Tipo Alterado" = Table.TransformColumnTypes(Data0,{{"Pareceres, Substitutivos e Votos", type text}, {"Tipo de Proposicao", type text}, {"Data de Apresentação", type date}, {"Autor", type text}, {"Descrição", type text}}),
    #"Personalização Adicionada" = Table.AddColumn(#"Tipo Alterado", "Local", each "Comissão de Constituição e Justiça e de Cidadania (CCJC )")
in
    #"Personalização Adicionada"