let
    Source = Xml.Tables(File.Contents("F:\FCD\VisualizacaoTramitacaoPL\votacao.xml"), null, 65001),
    Table0 = Source{0}[Table],
    Table1 = Table0{0}[Table],
    Table2 = Table1{0}[Table],
    Table3 = Table2{0}[Table],
    #"Changed Type" = Table.TransformColumnTypes(Table3,{{"Sigla", type text}, {"Numero", Int64.Type}, {"Ano", Int64.Type}}),
    Votacoes = #"Changed Type"{0}[Votacoes],
    #"Expanded Votacao" = Table.ExpandTableColumn(Votacoes, "Votacao", {"orientacaoBancada", "votos", "Attribute:Resumo", "Attribute:Data", "Attribute:Hora", "Attribute:ObjVotacao", "Attribute:codSessao"}, {"Votacao.orientacaoBancada", "Votacao.votos", "Votacao.Attribute:Resumo", "Votacao.Attribute:Data", "Votacao.Attribute:Hora", "Votacao.Attribute:ObjVotacao", "Votacao.Attribute:codSessao"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Votacao",{"Votacao.orientacaoBancada"}),
    #"Expanded Votacao.votos" = Table.ExpandTableColumn(#"Removed Columns", "Votacao.votos", {"Deputado"}, {"Votacao.votos.Deputado"}),
    #"Expanded Votacao.votos.Deputado" = Table.ExpandTableColumn(#"Expanded Votacao.votos", "Votacao.votos.Deputado", {"Attribute:Nome", "Attribute:ideCadastro", "Attribute:Partido", "Attribute:UF", "Attribute:Voto"}, {"Votacao.votos.Deputado.Attribute:Nome", "Votacao.votos.Deputado.Attribute:ideCadastro", "Votacao.votos.Deputado.Attribute:Partido", "Votacao.votos.Deputado.Attribute:UF", "Votacao.votos.Deputado.Attribute:Voto"}),
    #"Filtered Rows" = Table.SelectRows(#"Expanded Votacao.votos.Deputado", each true),
    #"Filtered Rows4" = Table.SelectRows(#"Filtered Rows", each true),
    #"Renamed Columns2" = Table.RenameColumns(#"Filtered Rows4",{{"Votacao.Attribute:codSessao", "CodSessao"}, {"Votacao.Attribute:ObjVotacao", "ObjVotacao"}, {"Votacao.Attribute:Hora", "VotacaoHora"}, {"Votacao.Attribute:Data", "VotacaoData"}, {"Votacao.Attribute:Resumo", "VotacaoResumoFull"}, {"Votacao.votos.Deputado.Attribute:Nome", "ParlamentarNome"}, {"Votacao.votos.Deputado.Attribute:ideCadastro", "ParlamentarID"}, {"Votacao.votos.Deputado.Attribute:Partido", "ParlamentarPartido"}, {"Votacao.votos.Deputado.Attribute:UF", "ParlamentarUF"}, {"Votacao.votos.Deputado.Attribute:Voto", "ParlamentarVoto"}}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Renamed Columns2",{{"ParlamentarNome", type text}, {"ParlamentarUF", type text}}),
    #"Changed Type with Locale" = Table.TransformColumnTypes(#"Changed Type3", {{"ParlamentarUF", type text}}, "pt-BR"),
    #"Changed Type4" = Table.TransformColumnTypes(#"Changed Type with Locale",{{"VotacaoData", type date}, {"VotacaoHora", type time}}),
    #"Renamed Columns3" = Table.RenameColumns(#"Changed Type4",{{"ObjVotacao", "Objeto de votação"}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Renamed Columns3","-","Ausente",Replacer.ReplaceText,{"ParlamentarVoto"}),
    #"Filtered Rows5" = Table.SelectRows(#"Replaced Value1", each true),
    #"Renamed Columns4" = Table.RenameColumns(#"Filtered Rows5",{{"ParlamentarUF", "UF Parlamentar"}, {"ParlamentarVoto", "Voto Parlamentar"}, {"ParlamentarPartido", "Partido Parlamentar"}, {"ParlamentarNome", "Nome Parlamentar"}, {"ParlamentarID", "ID Parlamentar"}}),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Renamed Columns4", "Voto Parlamentar", "Voto Parlamentar - Copy"),
    #"Reordered Columns" = Table.ReorderColumns(#"Duplicated Column1",{"Nome Parlamentar", "ID Parlamentar", "Partido Parlamentar", "UF Parlamentar", "Voto Parlamentar", "Voto Parlamentar - Copy", "VotacaoResumoFull", "VotacaoData", "VotacaoHora", "Objeto de votação", "CodSessao"}),
    #"Removed Columns6" = Table.RemoveColumns(#"Reordered Columns",{"Voto Parlamentar - Copy"}),
    #"Trimmed Text" = Table.TransformColumns(#"Removed Columns6",{{"Voto Parlamentar", Text.Trim, type text}}),
    #"Valor Substituído" = Table.ReplaceValue(#"Trimmed Text","Professor Luizão Goulart","Luizão Goulart",Replacer.ReplaceText,{"Nome Parlamentar"}),
    #"Colunas Reordenadas" = Table.ReorderColumns(#"Valor Substituído",{"Nome Parlamentar", "ID Parlamentar", "Partido Parlamentar", "UF Parlamentar", "Voto Parlamentar", "Objeto de votação", "VotacaoResumoFull", "VotacaoData", "VotacaoHora", "CodSessao"}),
    #"Consulta Acrescentada" = Table.Combine({#"Colunas Reordenadas", Emendas, Pareceres, Requerimentos, hist_tramitacao}),
    #"Valor Substituído1" = Table.ReplaceValue(#"Consulta Acrescentada","Não","Votação - Não",Replacer.ReplaceText,{"Voto Parlamentar"}),
    #"Valor Substituído2" = Table.ReplaceValue(#"Valor Substituído1","Ausente","Votação - Ausente",Replacer.ReplaceText,{"Voto Parlamentar"}),
    #"Valor Substituído3" = Table.ReplaceValue(#"Valor Substituído2","Sim","Votação - Sim",Replacer.ReplaceText,{"Voto Parlamentar"}),
    #"Valor Substituído4" = Table.ReplaceValue(#"Valor Substituído3","Art. 17","Votação - Art. 17",Replacer.ReplaceText,{"Voto Parlamentar"}),
    #"Valor Substituído5" = Table.ReplaceValue(#"Valor Substituído4","Obstrução","Votação - Obstrução",Replacer.ReplaceText,{"Voto Parlamentar"}),
    #"Valor Substituído6" = Table.ReplaceValue(#"Valor Substituído5","Abstenção","Votação - Abstenção",Replacer.ReplaceText,{"Voto Parlamentar"}),
    #"Linhas Filtradas" = Table.SelectRows(#"Valor Substituído6", each true),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Linhas Filtradas",{{"Voto Parlamentar", "Atuação Parlamentar"}, {"Objeto de votação", "Objeto de atuação"}}),
    #"Replaced Value" = Table.ReplaceValue(#"Colunas Renomeadas","Solidaried","SOLIDARIEDADE",Replacer.ReplaceText,{"Partido Parlamentar"}),
    #"Uppercased Text" = Table.TransformColumns(#"Replaced Value",{{"Partido Parlamentar", Text.Upper, type text}}),
    #"Cleaned Text" = Table.TransformColumns(#"Uppercased Text",{{"Partido Parlamentar", Text.Clean, type text}}),
    #"Filtered Rows1" = Table.SelectRows(#"Cleaned Text", each ([Nome Parlamentar] <> "Mauro Benevides Filho" and [Nome Parlamentar] <> "Merlong Solano" and [Nome Parlamentar] <> "Valtenir Pereira")),
    #"Changed Type with Locale1" = Table.TransformColumnTypes(#"Filtered Rows1", {{"UF Parlamentar", type text}}, "pt-BR")
in
    #"Changed Type with Locale1"