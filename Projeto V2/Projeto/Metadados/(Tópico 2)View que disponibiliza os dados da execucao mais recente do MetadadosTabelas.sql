
-- criar a view MetadadosTabelas_View
CREATE VIEW dbo.MetadadosTabelas_View
AS
SELECT
    NomeTabela,
    NomeColuna,
    TipoDados,
    Tamanho,
    Restricoes,
    DataAlteracao
FROM dbo.MetadadosTabelas
WHERE DataAlteracao = (SELECT MAX(DataAlteracao) FROM dbo.MetadadosTabelas);
