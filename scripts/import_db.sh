#!/bin/bash

# Verificar si existe el archivo a importar
if [ ! -f "./db_dump/db_export.sql" ]; then
    echo "Error: No se encuentra el archivo de base de datos en ./db_dump/db_export.sql"
    exit 1
fi

# Copiar el archivo al contenedor
docker cp ./db_dump/db_export.sql $(docker-compose ps -q wordpress):/var/www/html/db_import.sql

# Importar la base de datos
docker-compose exec -T wordpress wp db import /var/www/html/db_import.sql

# Limpiar el archivo temporal del contenedor
docker-compose exec -T wordpress rm /var/www/html/db_import.sql

echo "Base de datos importada exitosamente"