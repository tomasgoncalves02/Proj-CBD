CREATE TABLE Currency
(
    CurrencyKey INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyAlternateKey NVARCHAR(5) NOT NULL,
    CurrencyName NVARCHAR(55) NOT NULL,
	UNIQUE (CurrencyKey),
    UNIQUE (CurrencyAlternateKey),
    UNIQUE (CurrencyName)

);

INSERT INTO Currency (CurrencyAlternateKey, CurrencyName)
SELECT CurrencyAlternateKey, CurrencyName
FROM AdventureOldData.dbo.Currency;

