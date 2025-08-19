# Verificar si existe el archivo a importar
if (-not (Test-Path ".\db_dump\db_export.sql")) {
    Write-Host "Error: No se encuentra el archivo de base de datos en .\db_dump\db_export.sql"
    exit 1
}

# Obtener la contraseña del archivo .env
$ROOT_PASSWORD = (Get-Content .\.env | Select-String MYSQL_ROOT_PASSWORD).ToString().Split('=')[1]

# Importar la base de datos usando mysql
Get-Content .\db_dump\db_export.sql | docker-compose exec -T db mysql -u root -p"$ROOT_PASSWORD" wordpress

Write-Host "Base de datos importada exitosamente"