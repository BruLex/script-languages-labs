
#!/bin/bash

APP_NAME=lab-app

build() {
    mkdir tmp
    cp -R api proxy config.js package*.json tmp
    docker build -t "$APP_NAME-api" -f ./api/Dockerfile . || error_message
    docker build -t "$APP_NAME-proxy" -f ./proxy/Dockerfile . || error_message
    rm -rf tmp
}

deploy() {
    docker swarm init  || error_message
    docker stack deploy -c docker-compose.yml $APP_NAME  || error_message
}

stop() {
    docker stack rm $APP_NAME 
    docker swarm leave -f
}

error_message(){
    echo "Something go wrong"
    echo "Please try again later, if the problem persists, report the developer"
    exit 1
}

help_info() {
    echo "Usage: ./app-control COMMAND"
    echo "Options:"
    echo "	--build     Build app"
    echo "	--deploy    Start app"
    echo "	--stop      Stop app"
}

if [ "$1" != " " ]; then
    case $1 in
        --build ) build
            exit
        ;;
        --deploy ) deploy
            exit
        ;;
        --stop ) stop
            exit
        ;;
        * ) help_info
            exit 1
    esac
fi