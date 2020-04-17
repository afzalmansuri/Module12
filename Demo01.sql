-- Step 1 - Create a memory-optimized table

USE MemDemo
GO

CREATE TABLE dbo.MemoryTable
(	id INTEGER NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000000),
 	date_value DATETIME NULL
)
WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);


-- Step 2 - Create a disk-based table

CREATE TABLE dbo.DiskTable
(
	id INTEGER NOT NULL PRIMARY KEY NONCLUSTERED,
 	date_value DATETIME NULL
);


-- Step 3 - Insert 500,000 rows into DiskTable

BEGIN TRAN
	DECLARE @Diskid int = 1
	WHILE @Diskid <= 500000
	BEGIN
		INSERT INTO dbo.DiskTable VALUES (@Diskid, GETDATE())
		SET @Diskid += 1
	END
COMMIT;

-- Step 4 - Verify DiskTable contents 

SELECT COUNT(*) FROM dbo.DiskTable;

-- Step 5 - Insert 500,000 rows into MemoryTable 

BEGIN TRAN
	DECLARE @Memid int = 1
	WHILE @Memid <= 500000
	BEGIN
		INSERT INTO dbo.MemoryTable VALUES (@Memid, GETDATE())
		SET @Memid += 1
	END
COMMIT;

-- Step 6 - Verify MemoryTable contents


SELECT COUNT(*) FROM dbo.MemoryTable;


-- Step 7 - Delete rows from DiskTable 

DELETE FROM DiskTable;


-- Step 8 - Delete rows from MemoryTable 

DELETE FROM MemoryTable;

-- Step 9 - View memory-optimized table stats

SELECT o.Name, m.* FROM sys.dm_db_xtp_table_memory_stats m
JOIN sys.sysobjects o
ON m.object_id = o.id
