/* 202100728_202100744 */

// 1 criação base de dados
use AdventurWorksWeb


// Criando a coleção principal
db.createCollection("SalesInformation");

// Inserindo os documentos nas subcoleções
db.SalesInformation.insertMany({
  SalesByModelProductYear: [
    {
      model: "Modelo1",
      product: "ProdutoA",
      year: 2023,
      sales: 5000
    },
    {
      model: "Modelo2",
      product: "ProdutoB",
      year: 2023,
      sales: 7500
    }
  ],
  MonthlyAnnualSalesBalance: [
    {
      year: 2023,
      monthlySales: [
        { month: 1, sales: 10000 },
        { month: 2, sales: 12000 },
        { month: 12, sales: 15000 }
      ],
      annualBalance: 180000
    }
  ]
});

