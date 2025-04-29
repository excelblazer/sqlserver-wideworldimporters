#!/bin/bash

# Create backup folder if not exists
mkdir -p /var/opt/mssql/backup

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
sleep 20

# Download backup file
curl -L -o /var/opt/mssql/backup/WideWorldImporters-Full.bak \
  https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

# Restore database
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourStrong@Passw0rd' -Q \
"RESTORE DATABASE WideWorldImporters FROM DISK = '/var/opt/mssql/backup/WideWorldImporters-Full.bak' WITH MOVE 'WWI_Primary' TO '/var/opt/mssql/data/WideWorldImporters.mdf', MOVE 'WWI_Log' TO '/var/opt/mssql/data/WideWorldImporters.ldf'"
