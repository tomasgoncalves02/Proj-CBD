/* Importar os dados do sql server para mongodb */
SELECT * from MonthlyAnnualSalesBalance
FOR JSON PATH, ROOT('MonthlyAnnualSalesBalance');

SELECT * from SalesByModelProductYear
FOR JSON PATH, ROOT('SalesByModelProductYear');