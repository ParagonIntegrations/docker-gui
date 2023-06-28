#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
caddydockerfile = $parent_path/caddy/Dockerfile
vncdockerfile = $parent_path/vnc_docker/Dockerfile

docker login
cd "$parent_path/caddy"
docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag nelisvolschenk/vnc_docker_caddy:latest --push .

cd "$parent_path/vnc_docker"
docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag nelisvolschenk/vnc_docker_app:latest --push .
