IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'dwh' )
    EXEC('CREATE SCHEMA [dwh]');
GO
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('dwh.FactGreenTaxi'))
DROP TABLE dwh.FactGreenTaxi;
GO
CREATE  TABLE dwh.FactGreenTaxi (
	PartitionID int not null,
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
	)
	WITH
(   CLUSTERED COLUMNSTORE INDEX
,   DISTRIBUTION = HASH([vendorID])
,   PARTITION   (   [PartitionID] RANGE RIGHT FOR VALUES
                    (20000101,20010101,20020101
                    ,20030101,20040101,20050101
                    )
                )
);