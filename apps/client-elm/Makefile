install: container-elm-builder

container-elm-builder:
	docker build --tag elm-builder --file docker/elm-builder.Dockerfile .

up:
	docker-compose --file docker/docker-compose.yaml up -d 

build:
	docker run \
		--rm \
		--name elm-builder \
		--mount type=bind,source=`pwd`,target=/tmp/code \
		--workdir /tmp/code \
		elm-builder \
		elm make src/Main.elm --output=public/assets/elm.js

down:
	docker-compose --file docker/docker-compose.yaml down

reset: down up