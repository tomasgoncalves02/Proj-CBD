-- 202100728_202100744
/* Importar os dados do sql server para mongodb */
SELECT * from MonthlyAnnualSalesBalance
FOR JSON PATH, ROOT('MonthlyAnnualSalesBalance');
GO
SELECT * from SalesByModelProductYear
FOR JSON PATH, ROOT('SalesByModelProductYear');