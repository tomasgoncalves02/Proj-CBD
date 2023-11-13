create table Model (
    ModelKey int IDENTITY(1,1) NOT NULL,
    ModelName VARCHAR(255), 
    PRIMARY KEY (modelKey)
);

INSERT INTO Model(ModelName)
SELECT Distinct ModelName
FROM AdventureOldData.dbo.Products;