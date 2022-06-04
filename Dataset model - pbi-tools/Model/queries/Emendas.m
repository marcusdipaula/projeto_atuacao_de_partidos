let
    Fonte = Web.Page(Web.Contents("https://www.camara.leg.br/proposicoesWeb/prop_emendas?idProposicao=2193540&subst=0")),
    Data0 = Fonte{0}[Data],
    #"Tipo Alterado" = Table.TransformColumnTypes(Data0,{{"Emenda", type text}, {"Tipo de Emenda", type text}, {"Data de Apresentação", type date}, {"Autor", type text}, {"Ementa", type text}}),
    #"Texto Aparado" = Table.TransformColumns(#"Tipo Alterado",{{"Autor", Text.Trim, type text}}),
    #"Linhas Filtradas" = Table.SelectRows(#"Texto Aparado", each ([Autor] <> "Senado Federal")),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Linhas Filtradas",{{"Emenda", "Objeto de votação"}, {"Tipo de Emenda", "Voto Parlamentar"}, {"Data de Apresentação", "VotacaoData"}, {"Autor", "Nome Parlamentar"}}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Colunas Renomeadas",{"Ementa"})
in
    #"Colunas Removidas"