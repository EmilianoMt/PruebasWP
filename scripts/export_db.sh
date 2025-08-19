#!/bin/bash

# Crear directorio para dumps si no existe
mkdir -p ./db_dump

# Exportar la base de datos
docker-compose exec -T wordpress wp db export /var/www/html/db_export.sql

# Copiar el archivo exportado al host
docker cp $(docker-compose ps -q wordpress):/var/www/html/db_export.sql ./db_dump/db_export.sql

# Limpiar el archivo temporal del contenedor
docker-compose exec -T wordpress rm /var/www/html/db_export.sql