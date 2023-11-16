EXEC dbo.GerarEntradasTabelaMetadados;

SELECT * FROM dbo.MetadadosTabelas;

-- Consultar a VIEW MetadadosTabelas_View
SELECT * FROM dbo.MetadadosTabelas_View;


EXEC dbo.RegistrarEstatisticasTabelas;

SELECT * FROM dbo.EstatisticasTabelas;