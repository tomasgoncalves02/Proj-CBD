--Identificação: 202100744_202100728
-- Criação da tabela CategoryList
CREATE TABLE CategoryList
(
  CategoryListID INT IDENTITY(1,1) NOT NULL,
  ProductCategoryKey INT NOT NULL,
  ProductSubCategoryKey INT,
  PRIMARY KEY (CategoryListID),
  FOREIGN KEY (ProductCategoryKey) REFERENCES ProductCategory(ProductCategoryKey),
  FOREIGN KEY (ProductSubCategoryKey) REFERENCES ProductSubCategory(ProductSubCategoryKey),
);


-- Criar uma stored procedure para realizar a migração de dados
CREATE PROCEDURE dbo.MigrateCategoryListData
AS
BEGIN
    BEGIN TRY
        -- Inicie a transação para garantir consistência
        BEGIN TRANSACTION;

        -- Inserção de dados na tabela CategoryList
        INSERT INTO CategoryList (ProductCategoryKey, ProductSubCategoryKey)
        SELECT DISTINCT c.ProductCategoryKey, b.ProductSubCategoryKey
        FROM AdventureOldData.dbo.Products a
        INNER JOIN AdventureOldData.dbo.ProductSubCategory b ON a.ProductSubcategoryKey = b.ProductSubcategoryKey
        INNER JOIN AdventureWorks.dbo.ProductCategory c ON a.EnglishProductCategoryName COLLATE SQL_Latin1_General_CP1_CI_AS = c.EnglishProductCategoryName COLLATE SQL_Latin1_General_CP1_CI_AS;

        -- Commit da transação se a inserção for bem-sucedida
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback da transação em caso de erro
        ROLLBACK;

        -- Tratamento de erros
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Registo do erro num log de erros
        EXEC dbo.LogError @ErrorMessage, @ErrorNumber, @ErrorSeverity, @ErrorState;

        -- Exibir uma mensagem amigável para o utilizador
        THROW 50000, 'Ocorreu um erro durante a migração de dados da tabela CategoryList. Entre em contato com o suporte.', 1;
    END CATCH
END;

exec dbo.MigrateCategoryListData;
