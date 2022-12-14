#!/bin/bash
# sync docker
docker stop scsbackend && docker rm $_
docker rmi rollrat/scs-backend:latest
docker pull rollrat/scs-backend:latest

# download env-file for docker
aws s3api get-object --bucket scs-config --key .env.docker.prod .env.docker.prod

# setup docker
docker create --env-file ./.env.docker.prod \
                  --name scsbackend \
                  --network host \
                  --add-host host.docker.internal:host-gateway \
                  rollrat/scs-backend:latest

# download env & copy to container
aws s3api get-object --bucket scs-config --key .prod.env .prod.env
docker cp .prod.env scsbackend:/home/node/

# run docker
docker start scsbackend
docker rmi $(docker images -q rollrat/scs-backend)

rm .env.docker.prod
rm .prod.env
