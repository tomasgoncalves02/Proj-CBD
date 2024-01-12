--Identificacao 202100744_202100728
--Executar Procedimento GerarEntradasTabelaMetadados
EXEC dbo.GerarEntradasTabelaMetadados;

-- Consultar a Tabela MetadadosTabelas
SELECT * FROM dbo.MetadadosTabelas;

-- Consultar a VIEW MetadadosTabelas_View
SELECT * FROM dbo.MetadadosTabelas_View;

--Executar Procedimento RegistrarEstatisticasTabelas
EXEC dbo.RegistrarEstatisticasTabelas;

-- Consultar a Tabela EstatisticasTabelas
SELECT * FROM dbo.EstatisticasTabelas;