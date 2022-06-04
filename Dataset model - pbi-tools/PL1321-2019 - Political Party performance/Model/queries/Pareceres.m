let
    Fonte = Web.Page(Web.Contents("https://www.camara.leg.br/proposicoesWeb/prop_pareceres_substitutivos_votos?idProposicao=2193540")),
    Data2 = Fonte{2}[Data],
    #"Tipo Alterado" = Table.TransformColumnTypes(Data2,{{"Pareceres, Substitutivos e Votos", type text}, {"Tipo de Proposicao", type text}, {"Data de Apresentação", type date}, {"Autor", type text}, {"Descrição", type text}}),
    #"Personalização Adicionada" = Table.AddColumn(#"Tipo Alterado", "Local", each "PLENÁRIO (PLEN)"),
    #"Consulta Acrescentada" = Table.Combine({#"Personalização Adicionada", #"Comissão de Finanças e Tributação (CFT       )", #"Comissão de Constituição e Justiça e de Cidadania (CCJC      )"}),
    #"Texto Aparado" = Table.TransformColumns(#"Consulta Acrescentada",{{"Autor", Text.Trim, type text}}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Texto Aparado",{{"Autor", "Nome Parlamentar"}, {"Data de Apresentação", "VotacaoData"}, {"Tipo de Proposicao", "Voto Parlamentar"}, {"Pareceres, Substitutivos e Votos", "Objeto de votação"}}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Colunas Renomeadas",{"Local", "Descrição"})
in
    #"Colunas Removidas"