ALTER  PROCEDURE dwh.SpMajFactGreenTaxi AS 
BEGIN
    TRUNCATE TABLE dbo.FactGreenTaxi;
    INSERT INTO dbo.FactGreenTaxi
    SELECT * FROM ext.GreenTaxi;

    TRUNCATE TABLE dwh.FactGreenTaxi;
    INSERT INTO dwh.FactGreenTaxi
    SELECT convert(varchar(12),cast([lpepPickupDatetime]as date),112)/100 PartitionID,* FROM dbo.FactGreenTaxi;


END

