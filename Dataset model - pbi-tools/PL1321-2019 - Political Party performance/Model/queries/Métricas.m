let
    Fonte = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [#"Coluna 1" = _t]),
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Coluna 1", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Tipo Alterado",{"Coluna 1"})
in
    #"Removed Columns"