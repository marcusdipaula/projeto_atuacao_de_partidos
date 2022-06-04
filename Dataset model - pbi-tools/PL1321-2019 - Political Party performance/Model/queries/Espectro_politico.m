let
    Source = Web.Page(Web.Contents("https://pt.wikipedia.org/wiki/Lista_de_partidos_pol%C3%ADticos_do_Brasil")),
    Data1 = Source{1}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Data1,{{"Nome", type text}, {"Fernandes (1995)[43][44]", type text}, {"Coppedge (1997)[43][44]", type text}, {"O Globo (2016)[45]", type text}, {"BBC Brasil (2017)[46]", type text}, {"Claudio Couto (2018)[47]", type text}, {"Folha de S.Paulo (2018)[48]", type text}, {"Congresso em Foco (2019)[49]", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Fernandes (1995)[43][44]", "Coppedge (1997)[43][44]", "O Globo (2016)[45]", "BBC Brasil (2017)[46]", "Claudio Couto (2018)[47]", "Folha de S.Paulo (2018)[48]"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Columns","—","esquerda",Replacer.ReplaceText,{"Congresso em Foco (2019)[49]"}),
    #"Removed Top Rows" = Table.Skip(#"Replaced Value",1),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Top Rows",{{"Congresso em Foco (2019)[49]", "Espectro"}, {"Nome", "Partido"}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Renamed Columns","PPS","CIDADANIA",Replacer.ReplaceText,{"Partido"}),
    #"Uppercased Text" = Table.TransformColumns(#"Replaced Value1",{{"Partido", Text.Upper, type text}, {"Espectro", Text.Upper, type text}})
in
    #"Uppercased Text"