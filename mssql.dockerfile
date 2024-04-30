# the official SQL Server image
FROM mcr.microsoft.com/mssql/server:latest
# accept the End-User License Agreement
ENV ACCEPT_EULA=Y
#  SA password
ENV SA_PASSWORD="Un!q@to2023"
