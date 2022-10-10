docker stop scsbackend && docker rm $_
docker pull rollrat/scs-backend:latest
docker run -d --name scsbackend --network host rollrat/scs-backend:latest
docker rmi $(docker images -q rollrat/scsbackend)