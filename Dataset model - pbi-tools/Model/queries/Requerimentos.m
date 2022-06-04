let
    Fonte = Web.Page(Web.Contents("https://www.camara.leg.br/proposicoesWeb/prop_requerimentos?idProposicao=2193540")),
    Data0 = Fonte{0}[Data],
    #"Tipo Alterado" = Table.TransformColumnTypes(Data0,{{"Número", type text}, {"Tipo", type text}, {"Data de Apresentação", type date}, {"Autor", type text}, {"Ementa", type text}}),
    #"Texto Aparado" = Table.TransformColumns(#"Tipo Alterado",{{"Autor", Text.Trim, type text}}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Texto Aparado",{{"Tipo", "Voto Parlamentar"}, {"Data de Apresentação", "VotacaoData"}, {"Autor", "Nome Parlamentar"}, {"Número", "Objeto de votação"}}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Colunas Renomeadas",{"Ementa"})
in
    #"Colunas Removidas"