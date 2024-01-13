/* 202100728_202100744 */

//5
// Listar por Produto o "histórico de vendas" adquiridos por cidade
db.SalesInformation.aggregate([
  {
    $unwind: "$SalesByModelProductYear"
  },
  {
    $lookup: {
      from: "SalesOrders",
      localField: "SalesByModelProductYear.SalesOrderNumber",
      foreignField: "SalesOrderNumber",
      as: "orderDetails"
    }
  },
  {
    $unwind: "$orderDetails"
  },
  {
    $lookup: {
      from: "Customer",
      localField: "orderDetails.CustomerKey",
      foreignField: "CustomerKey",
      as: "customerInfo"
    }
  },
  {
    $project: {
      _id: 0,
      EnglishProductName: "$SalesByModelProductYear.EnglishProductName",
      City: "$customerInfo.City",
      SalesAmount: "$SalesByModelProductYear.SalesAmount"
    }
  }
])


// Listar por Produto o valor total por mês/ano e a média mensal
db.SalesInformation.aggregate([
  {
    $unwind: "$MonthlyAnnualSalesBalance"
  },
  {
    $group: {
      _id: {
        Product: "$MonthlyAnnualSalesBalance.EnglishProductName",
        Year: "$MonthlyAnnualSalesBalance.year",
        Month: { $arrayElemAt: ["$MonthlyAnnualSalesBalance.monthlySales.month", 0] }
      },
      TotalSales: { $sum: "$MonthlyAnnualSalesBalance.monthlySales.sales" }
    }
  },
  {
    $project: {
      _id: 0,
      Product: "$_id.Product",
      Year: "$_id.Year",
      Month: "$_id.Month",
      TotalSales: 1
    }
  }
])


// Listar por Modelo, os produtos e quantidades adquiridas
db.SalesInformation.aggregate([
  {
    $unwind: "$SalesByModelProductYear"
  },
  {
    $group: {
      _id: {
        Model: "$SalesByModelProductYear.model",
        Product: "$SalesByModelProductYear.product"
      },
      TotalQuantity: { $sum: "$SalesByModelProductYear.sales" }
    }
  },
  {
    $project: {
      _id: 0,
      Model: "$_id.Model",
      Product: "$_id.Product",
      TotalQuantity: 1
    }
  }
])
