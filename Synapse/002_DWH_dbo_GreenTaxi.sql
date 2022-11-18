
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'landingzone_synapseadlsfromdax_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [landingzone_synapseadlsfromdax_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://landingzone@synapseadlsfromdax.dfs.core.windows.net' 
	)
GO
DROP  EXTERNAL TABLE GreenTaxi
GO
CREATE EXTERNAL TABLE GreenTaxi (
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
	WITH (
	LOCATION = 'nyctlc/green/puYear=*/puMonth=*/*.parquet',
	DATA_SOURCE = [landingzone_synapseadlsfromdax_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

