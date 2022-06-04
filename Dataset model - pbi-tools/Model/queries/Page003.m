let
    Source = Pdf.Tables(File.Contents("C:\Users\marcu\AppData\Local\Packages\Microsoft.MicrosoftPowerBIDesktop_8wekyb3d8bbwe\AC\INetCache\4ERO8QM4\prop_mostrarintegra[1]")),
    Page1 = Source{[Id="Page003"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Page1,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"Column2"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Column2", "Column"}}),
    #"Removed Blank Rows" = Table.SelectRows(#"Renamed Columns", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Removed Top Rows" = Table.Skip(#"Removed Blank Rows",1),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Top Rows",".............................................................................................","NULL",Replacer.ReplaceText,{"Column"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","NULL","",Replacer.ReplaceText,{"Column"}),
    #"Removed Blank Rows1" = Table.SelectRows(#"Replaced Value1", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Replaced Value2" = Table.ReplaceValue(#"Removed Blank Rows1","§1º É","",Replacer.ReplaceText,{"Column"}),
    #"Replaced Value3" = Table.ReplaceValue(#"Replaced Value2","“Art. 17","",Replacer.ReplaceText,{"Column"}),
    #"Removed Blank Rows2" = Table.SelectRows(#"Replaced Value3", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))
in
    #"Removed Blank Rows2"