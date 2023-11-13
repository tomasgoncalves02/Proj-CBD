
--Criacao da view ProdutosEmEstoqueView
CREATE VIEW ProdutosEmEstoqueView AS
    SELECT 
        P.EnglishProductName AS NomeDoProduto,
        P.ListPrice AS PrecoDoProduto,
        P.StandardCost AS CustoDoProduto
    FROM Products AS P
    WHERE P.FinishedGoodsFlag = 'TRUE';


--Query da view ProdutosEmEstoqueView
SELECT * FROM ProdutosEmEstoqueView;

