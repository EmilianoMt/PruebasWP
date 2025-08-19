#!/bin/bash
docker-compose exec wordpress wp db export /var/www/html/db_export.sql
docker cp $(docker-compose ps -q wordpress):/var/www/html/db_export.sql ./db_dump/db_export.sql
