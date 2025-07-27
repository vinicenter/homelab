#!/bin/bash

source ./.env

DESTINATION_IP=$DESTINATION_IP GATEWAY_HOST=$GATEWAY_HOST envsubst '${DESTINATION_IP} ${GATEWAY_HOST}' < ./nginx/nginx.conf.template > ./nginx/nginx.conf
docker compose up
