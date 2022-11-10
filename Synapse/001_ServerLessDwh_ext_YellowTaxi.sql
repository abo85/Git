USE ServerLessDwh
GO
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'ext' )
    EXEC('CREATE SCHEMA [ext]');
go
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nyctlc_azureopendatastorage_blob_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [nyctlc_azureopendatastorage_blob_core_windows_net] 
	WITH (
		LOCATION   = 'https://azureopendatastorage.blob.core.windows.net/nyctlc', 
	)
Go

DROP  EXTERNAL TABLE ext.YellowTaxis 
GO
CREATE EXTERNAL TABLE ext.YellowTaxis (
	[vendorID] varchar(8000),
	[tpepPickupDateTime] datetime2(7),
	[tpepDropoffDateTime] datetime2(7),
	[passengerCount] int,
	[tripDistance] float,
	[puLocationId] varchar(8000),
	[doLocationId] varchar(8000),
	[startLon] float,
	[startLat] float,
	[endLon] float,
	[endLat] float,
	[rateCodeId] int,
	[storeAndFwdFlag] varchar(8000),
	[paymentType] varchar(8000),
	[fareAmount] float,
	[extra] float,
	[mtaTax] float,
	[improvementSurcharge] varchar(8000),
	[tipAmount] float,
	[tollsAmount] float,
	[totalAmount] float
	)
	WITH (
	LOCATION = 'yellow/puYear=*/puMonth=*/*.parquet',
	DATA_SOURCE = [nyctlc_azureopendatastorage_blob_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

--SELECT TOP 100 * FROM ext.YellowTaxis
GO

