#!/bin/bash

bash ./generateNginxConfig.sh
docker compose down
docker compose up -d --force-recreate
