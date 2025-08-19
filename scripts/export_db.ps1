# Crear directorio para dumps si no existe
New-Item -ItemType Directory -Force -Path .\db_dump

# Obtener la contraseña del archivo .env
$ROOT_PASSWORD = (Get-Content .\.env | Select-String MYSQL_ROOT_PASSWORD).ToString().Split('=')[1]

# Exportar la base de datos usando mysqldump
docker-compose exec db mysqldump -u root -p"$ROOT_PASSWORD" wordpress | Out-File -Encoding UTF8 .\db_dump\db_export.sql

Write-Host "Base de datos exportada exitosamente en ./db_dump/db_export.sql"