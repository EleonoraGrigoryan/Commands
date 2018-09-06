
-- Select columns of the user created tables and the type of each one

    select obj.name, col.name, type_name(col.user_type_id)
    from sys.objects as obj
    inner join sys.columns as col on obj.object_id = col.object_id
    where obj.type = 'u'
    
-- Select user defined indexes on user tables - not heaps

    select 
    idx.[name] as [Index]
    from sys.indexes as idx
    inner join sys.objects as obj on idx.object_id = obj.object_id
    where idx.[name] is not null and obj.[type] = 'u'
    order by idx.[name]

-- Find all the instance names in a server

    Create Table #GetInstances
    ( 
        [Value] nvarchar(100),
        [InstanceNames] nvarchar(100),
        [Data] nvarchar(100)
    )
    Insert into #GetInstances
    EXECUTE xp_regread
      @rootkey = 'HKEY_LOCAL_MACHINE',
      @key = 'SOFTWARE\Microsoft\Microsoft SQL Server',
      @value_name = 'InstalledInstances'

    Select InstanceNames from #GetInstances
    drop table #GetInstances


-- select script of logon triggers
SELECT
    SSM.definition
FROM
    sys.server_triggers AS ST JOIN
    sys.server_sql_modules AS SSM
        ON ST.object_id = SSM.object_id
