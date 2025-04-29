#!/bin/bash

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
sleep 20

# Download WideWorldImporters backup file
curl -L -o /var/opt/mssql/backup/WideWorldImporters-Full.bak \
  https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

# Restore the database
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'dummy@123' -Q \
"RESTORE DATABASE WideWorldImporters FROM DISK = '/var/opt/mssql/backup/WideWorldImporters-Full.bak' WITH MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf', MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf'"
