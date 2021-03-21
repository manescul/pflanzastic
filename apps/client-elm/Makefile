install: install-elm-builder

install-elm-builder:
	docker build \
		--target prod-elm-builder \
		--tag elm-builder \
		--build-arg uname=${id -un} \
		--build-arg uid=${id -u} \
		.

dev-install-elm-builder:
	docker build \
		--target dev-elm-builder \ 
		--tag dev-elm-builder \
		--build-arg uname=${id -un} \
		--build-arg uid=${id -u} \
		.

build:
	docker run \
		--rm \
		--name elm-builder \
		--mount type=bind,source=`pwd`,target=/tmp/pflanzastic \
		--workdir /tmp/pflanzastic \
		elm-builder \
		elm make src/Main.elm --output=public/assets/elm.js

up:
	docker-compose --file docker/docker-compose.yaml up -d 

down:
	docker-compose --file docker/docker-compose.yaml down

dev-up:
	docker-compose --file docker/docker-compose.dev.yaml up -d 

dev-down:
	docker-compose --file docker/docker-compose.dev.yaml down

reset: down up