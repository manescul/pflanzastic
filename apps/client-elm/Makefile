UID := $(shell id -u)
UNAME := $(shell id -un)
GID := $(shell id -g)

# Common targets
prune: prune-images

prune-images:
	  docker image ls --filter "dangling=true" --quiet | xargs docker image rm \
	 && 

install: install-elm-builder
install-elm-builder:
	docker build \
		--target pflanzastic-prod-elm-builder \
		--tag pflanzastic-prod-elm-builder \
		--build-arg uid=$(UID) \
		--build-arg uname=$(UNAME) \
		--build-arg gid=$(GID) \
		--build-arg gname=$(GNAME) \
		.
build:
	docker run \
		--rm \
		--name pflanzastic-prod-elm-builder \
		--mount type=bind,source=`pwd`,target=/tmp/code \
		--workdir /tmp/code \
		pflanzastic-prod-elm-builder \
		elm make src/Main.elm --output=./public/assets/elm.js


###################
# DEV environment #
###################

dev-install: dev-install-elm-builder

dev-install-elm-builder:
	docker build \
		--target pflanzastic-dev-elm-builder \ 
		--tag pflanzastic-dev-elm-builder \
		--build-arg uid=$(UID) \
		--build-arg uname=$(UNAME) \
		--build-arg gid=$(GID) \
		--build-arg gname=$(GNAME) \
		.

up:
	docker-compose --file docker/docker-compose.yaml up -d 

down:
	docker-compose --file docker/docker-compose.yaml down

dev-up:
	docker-compose --file docker/docker-compose.dev.yaml up -d 

dev-down:
	docker-compose --file docker/docker-compose.dev.yaml down

reset: down up
