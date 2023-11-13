create table Color(
ColorKey INT IDENTITY(1,1) PRIMARY KEY  NOT NULL,
Color nvarchar(55) NOT NULL);

INSERT INTO Color (Color)
SELECT Distinct Color
FROM AdventureOldData.dbo.Products;