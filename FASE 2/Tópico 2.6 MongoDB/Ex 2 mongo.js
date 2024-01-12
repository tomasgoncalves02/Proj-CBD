/* 2 Implementacao das collections necessárias de modo a suportar a informação disponibilizada no site */
db.createCollection("SalesByModelProductYear")
db.createCollection("MonthlyAnnualSalesBalance")

// SalesByModelProductYear
db.SalesByModelProductYear.insertMany([
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
    },
]);

// MonthlyAnnualSalesBalance
db.MonthlyAnnualSalesBalance.insertMany([
    {
      year: 2023,
      monthlySales: [
        { month: 1, sales: 10000 },
        { month: 2, sales: 12000 },
        { month: 12, sales: 15000 }
      ],
      annualBalance: 180000
    },
  ]);
  
