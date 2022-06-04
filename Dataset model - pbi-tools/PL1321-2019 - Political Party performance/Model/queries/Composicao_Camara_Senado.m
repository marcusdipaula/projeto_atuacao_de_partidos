let
    Source = Web.Page(Web.Contents("https://pt.wikipedia.org/wiki/Congresso_Nacional_do_Brasil")),
    Data1 = Source{1}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Data1,{{"Coligação", type text}, {"Partidos", type text}, {"Partidos2", type text}, {"Câmara Votos", type text}, {"Câmara % dos votos", type text}, {"Câmara Assentos", type text}, {"Câmara % dos assentos", type text}, {"Câmara +/–", type text}, {"Senado Votos", type text}, {"Senado % dos votos", type text}, {"Senado Novos assentos", type text}, {"Senado Total de assentos", type text}, {"Senado % dos assentos", type text}, {"Senado +/–", type text}, {"Column15", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"Coligação", "Partidos2", "Câmara Votos", "Câmara Assentos", "Senado Votos", "Senado Total de assentos"}),
    #"Removed Top Rows" = Table.Skip(#"Removed Other Columns",2),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Top Rows",{{"Partidos2", "Partidos"}, {"Câmara Votos", "Camara_votos"}, {"Senado Total de assentos", "Senado_assentos"}, {"Senado Votos", "Senado_votos"}, {"Câmara Assentos", "Camara_assentos"}, {"Coligação", "Coligacao"}}),
    #"Filtered Rows" = Table.SelectRows(#"Renamed Columns", each ([Partidos] <> "Referências: Câmara, Senado" and [Partidos] <> "Total" and [Partidos] <> "Total de votos válidos")),
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows",".","",Replacer.ReplaceText,{"Senado_votos"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",".","",Replacer.ReplaceText,{"Camara_votos"}),
    #"Coluna Condicional Adicionada" = Table.AddColumn(#"Replaced Value1", "Personalizar", each if [Partidos] = "Partido dos Trabalhadores" then "PT" else if [Partidos] = "Partido do Movimento Democrático Brasileiro" then "MDB" else if [Partidos] = "Partido Social Democrático" then "PSD" else if [Partidos] = "Partido Progressista" then "PP" else if [Partidos] = "Partido da República" then "PL" else if [Partidos] = "Partido Republicano Brasileiro" then "PRB" else if [Partidos] = "Partido Democrático Trabalhista" then "PDT" else if [Partidos] = "Partido Republicano da Ordem Social" then "PROS" else if [Partidos] = "Partido Comunista do Brasil" then "PCdoB" else if [Partidos] = "Partido da Social Democracia Brasileira" then "PSDB" else if [Partidos] = "Partido Trabalhista Brasileiro" then "PTB" else if [Partidos] = "Democratas" then "DEM" else if [Partidos] = "Solidariedade" then "SOLIDARIEDADE" else if [Partidos] = "Partido Trabalhista Nacional" then "PODEMOS" else if [Partidos] = "Partido da Mobilização Nacional" then "PMN" else if [Partidos] = "Partido Ecológico Nacional" then "PATRIOTA" else if [Partidos] = "Partido Trabalhista Cristão" then "PTC" else if [Partidos] = "Partido Trabalhista do Brasil" then "AVANTE" else if [Partidos] = "Partido Socialista Brasileiro" then "PSB" else if [Partidos] = "Partido Popular Socialista" then "CIDADANIA" else if [Partidos] = "Partido Humanista da Solidariedade" then "PHS" else if [Partidos] = "Partido Republicano Progressista" then "PRP" else if [Partidos] = "Partido Social Liberal" then "PSL" else if [Partidos] = "Partido Pátria Livre" then "PPL" else if [Partidos] = "Partido Social Cristão" then "PSC" else if [Partidos] = "Partido Verde" then "PV" else if [Partidos] = "Partido Socialismo e Liberdade" then "PSOL" else if [Partidos] = "Partido Social Democrata Cristão" then "PSDC" else if [Partidos] = "Partido Renovador Trabalhista Brasileiro" then "PRTB" else if [Partidos] = "Partido Socialista dos Trabalhadores Unificado" then "PSTU" else if [Partidos] = "Partido Comunista Brasileiro" then "PCB" else if [Partidos] = "Partido da Causa Operária" then "PCO" else null, type text),
    #"Renamed Columns1" = Table.RenameColumns(#"Coluna Condicional Adicionada",{{"Personalizar", "Partido"}}),
    #"Cleaned Text" = Table.TransformColumns(#"Renamed Columns1",{{"Partido", Text.Clean, type text}})
in
    #"Cleaned Text"