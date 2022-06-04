let
    Source = Pdf.Tables(File.Contents("C:\Users\marcu\AppData\Local\Packages\Microsoft.MicrosoftPowerBIDesktop_8wekyb3d8bbwe\AC\INetCache\4ERO8QM4\prop_mostrarintegra[1]")),
    Page1 = Source{[Id="Page001"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Page1,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"Column3"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Column3", "Column"}}),
    #"Removed Blank Rows" = Table.SelectRows(#"Renamed Columns", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Removed Bottom Rows" = Table.RemoveLastN(#"Removed Blank Rows",1),
    #"Removed Top Rows" = Table.Skip(#"Removed Bottom Rows",3),
    #"Removed Top Rows1" = Table.Skip(#"Removed Top Rows",1)
in
    #"Removed Top Rows1"