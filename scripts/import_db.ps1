# Verificar si existe el archivo a importar
if (-not (Test-Path ".\db_dump\db_export.sql")) {
    Write-Host "Error: No se encuentra el archivo de base de datos en .\db_dump\db_export.sql"
    exit 1
}

# Obtener la contraseña del archivo .env
$ROOT_PASSWORD = (Get-Content .\.env | Select-String MYSQL_ROOT_PASSWORD).ToString().Split('=')[1]

# Verificar si los contenedores están corriendo
$running = docker-compose ps --status running
if (-not $running) {
    Write-Host "Error: Los contenedores no están ejecutándose. Iniciando contenedores..."
    docker-compose up -d
    Start-Sleep -Seconds 10 # Esperar a que los servicios inicien
}

# Importar la base de datos usando mysql
Get-Content .\db_dump\db_export.sql | docker-compose exec -T database mysql -u root -p"$ROOT_PASSWORD" wordpress

if ($LASTEXITCODE -eq 0) {
    Write-Host "Base de datos importada exitosamente"
} else {
    Write-Host "Error: No se pudo importar la base de datos"
}