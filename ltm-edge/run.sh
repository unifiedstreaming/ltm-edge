export IP_BACKEND="127.0.0.1"
docker-compose stop
docker-compose rm -f
docker-compose build
docker-compose up -d
docker-compose logs
