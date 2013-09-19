SELECT

r.scheduler_id,

r.session_id,

r.command Command,

t.text SQL_Statment,

r.blocking_session_id Blocking_Session_ID,

r.total_elapsed_time/1000 Total_Elapsed_Time_Seconds,

r.cpu_time CPU_Time,

s.login_name Login_Name,

s.[host_name] [Host_Name],

s.[program_name] [Program_name],

s.memory_usage Memory_Usage,

r.status [Status],

db_name(r.database_id) Database_Name,

r.wait_type Wait_Type,

r.wait_time Wait_time,

r.wait_resource,

r.reads Reads,

r.writes Writes,

r.logical_reads Logical_Reads

FROM sys.dm_exec_requests r

INNER JOIN sys.dm_exec_sessions s

ON r.session_id = s.session_id

CROSS APPLY sys.dm_exec_sql_text(sql_handle) t

WHERE

r.session_id <> @@spid  --and blocking_session_id = -4

ORDER BY 2 DESC
