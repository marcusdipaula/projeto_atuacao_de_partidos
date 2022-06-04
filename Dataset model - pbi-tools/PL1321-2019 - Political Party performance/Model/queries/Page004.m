let
    Source = Pdf.Tables(File.Contents("C:\Users\marcu\AppData\Local\Packages\Microsoft.MicrosoftPowerBIDesktop_8wekyb3d8bbwe\AC\INetCache\4ERO8QM4\prop_mostrarintegra[1]")),
    Page1 = Source{[Id="Page004"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Page1,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}, {"Column20", type text}, {"Column21", type text}, {"Column22", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"Column5"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Column5", "Column"}}),
    #"Removed Blank Rows" = Table.SelectRows(#"Renamed Columns", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Removed Bottom Rows" = Table.RemoveLastN(#"Removed Blank Rows",2),
    #"Removed Top Rows" = Table.Skip(#"Removed Bottom Rows",1),
    #"Appended Query" = Table.Combine({#"Removed Top Rows", Page001, Page002, Page003}),
    #"Renamed Columns1" = Table.RenameColumns(#"Appended Query",{{"Column", "Texto_PL"}})
in
    #"Renamed Columns1"