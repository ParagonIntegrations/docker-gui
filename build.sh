#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
caddypath=$parent_path/caddy
vncdockerpath=$parent_path/vnc_docker
base=python
version=3.11.4-bookworm
baseimg=$base:$version
platforms=linux/amd64,linux/arm/v7,linux/arm64/v8
notusedplatforms=linux/386

docker login -u nelisvolschenk -p dckr_pat_tjT__eHx0_KRTSMOxwKFs5cKWnw
#cd "$caddypath"
#docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag nelisvolschenk/vnc_docker_caddy:latest --push .

cd "$vncdockerpath"
docker buildx build --build-arg BASE_IMAGE="$baseimg" --platform "$platforms" --tag "nelisvolschenk/vnc_docker_base:$base-$version" --push .
