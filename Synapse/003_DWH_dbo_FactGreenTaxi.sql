IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('dbo.FactGreenTaxi') )
DROP TABLE FactGreenTaxi
GO
CREATE TABLE FactGreenTaxi (
	[vendorID] int,
	[lpepPickupDatetime] datetime2(7),
	[lpepDropoffDatetime] datetime2(7),
	[passengerCount] int,
	[tripDistance] float,
	[puLocationId] nvarchar(4000),
	[doLocationId] nvarchar(4000),
	[pickupLongitude] float,
	[pickupLatitude] float,
	[dropoffLongitude] float,
	[dropoffLatitude] float,
	[rateCodeID] int,
	[storeAndFwdFlag] nvarchar(4000),
	[paymentType] int,
	[fareAmount] float,
	[extra] float,
	[mtaTax] float,
	[improvementSurcharge] nvarchar(4000),
	[tipAmount] float,
	[tollsAmount] float,
	[ehailFee] float,
	[totalAmount] float,
	[tripType] int
	)WITH
		(
 			DISTRIBUTION = ROUND_ROBIN
 			,HEAP
		)
	
GO

