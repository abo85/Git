-- Create a table containing the partition boundaries

DECLARE      
        @s NVARCHAR(128)    = N'dwh'               --schema
,       @t NVARCHAR(128)    = N'FactGreenTaxi'      --table;
,       @DateDebut date='2008-01-01'
,       @DateFin date='2022-12-31'
DROP TABLE #partitions;
CREATE TABLE #partitions
WITH
(
    LOCATION = USER_DB
,   DISTRIBUTION = HASH(ptn_no)
)
AS
SELECT  ptn_no
,       ROW_NUMBER() OVER (ORDER BY (ptn_no)) as seq_no
FROM    (
            select distinct MonthKey  as ptn_no
            from dwh.DimDate 
            where [Date] BETWEEN @DateDebut and @DateFin
        ) a;

 -- Iterate over the partition boundaries and split the table

DECLARE @c INT = (SELECT COUNT(*) FROM #partitions)
,       @i INT = 1                                 --iterator for while loop
,       @q NVARCHAR(4000)                          --query
,       @p NVARCHAR(20)     = N''                  --partition_number;

WHILE @i <= @c
BEGIN
    SET @p = (SELECT ptn_no FROM #partitions WHERE seq_no = @i);
    SET @q = (SELECT N'ALTER TABLE '+@s+N'.'+@t+N' SPLIT RANGE ('+@p+N');');

    -- PRINT @q;
    EXECUTE sp_executesql @q;
    SET @i+=1;
END

 -- Code clean-up

DROP TABLE #partitions;