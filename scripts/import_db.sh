#!/bin/bash
docker cp ./db_dump/db_export.sql $(docker-compose ps -q wordpress):/var/www/html/db_import.sql
docker-compose exec wordpress wp db import /var/www/html/db_import.sql
run