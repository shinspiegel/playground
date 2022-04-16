## Express/Neo4j Containerized Environment
by Alex Merced of AlexMercedCoder.com

## env_files

.env.express - env variables for node/express container
.env.neo4j - env variables neo4j container

## Commands

- Build Docker Compose File `docker-compose build`

- Run Docker Compose `docker-compose up -d`

- Take down compose with volumes `docker-compose down -v`

- Run and Build `docker-compose up -d --build`

- Run a command `docker-compose exec <service> <command>`

- check if volume exists `docker volume inspect <networkname>_<volumename>`

- Remove a volume `docker-compose rm <servicename>`

- Make script executable `chmod +x SCRIPT.sh`

- Docker Compose with custom file `$ docker-compose -f <FILE.yml> up -d --build`