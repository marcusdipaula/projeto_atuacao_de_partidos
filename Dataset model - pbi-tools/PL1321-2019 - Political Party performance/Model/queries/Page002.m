let
    Source = Pdf.Tables(File.Contents("C:\Users\marcu\AppData\Local\Packages\Microsoft.MicrosoftPowerBIDesktop_8wekyb3d8bbwe\AC\INetCache\4ERO8QM4\prop_mostrarintegra[1]")),
    Page1 = Source{[Id="Page002"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Page1,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"Column2"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Column2", "Column"}}),
    #"Removed Blank Rows" = Table.SelectRows(#"Renamed Columns", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Blank Rows","§","",Replacer.ReplaceText,{"Column"}),
    #"Removed Top Rows" = Table.Skip(#"Replaced Value",3),
    #"Removed Blank Rows1" = Table.SelectRows(#"Removed Top Rows", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))
in
    #"Removed Blank Rows1"