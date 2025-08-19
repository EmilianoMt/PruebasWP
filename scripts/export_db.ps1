# Crear directorio para dumps si no existe
New-Item -ItemType Directory -Force -Path .\db_dump

# Obtener la contraseña del archivo .env
$ROOT_PASSWORD = (Get-Content .\.env | Select-String MYSQL_ROOT_PASSWORD).ToString().Split('=')[1]

# Verificar si los contenedores están corriendo
$running = docker-compose ps --status running
if (-not $running) {
    Write-Host "Error: Los contenedores no están ejecutándose. Iniciando contenedores..."
    docker-compose up -d
    Start-Sleep -Seconds 10 # Esperar a que los servicios inicien
}

# Exportar la base de datos usando mysqldump con método alternativo
$result = docker-compose exec database mysqldump --no-tablespaces -u root -p"$ROOT_PASSWORD" wordpress
if ($result) {
    $result | Set-Content -Path ".\db_dump\db_export.sql" -Encoding UTF8
    Write-Host "Base de datos exportada exitosamente en ./db_dump/db_export.sql"
} else {
    Write-Host "Error: No se pudo exportar la base de datos"
}