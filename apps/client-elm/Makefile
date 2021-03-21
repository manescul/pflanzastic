UID := $(shell id -u)
UNAME := $(shell id -un)
GID := $(shell id -g)


##########
# Common #
##########
prune: kill-containers prune-dangling-images prune-pflanzastic-images
	@echo "Done"

kill-containers:
	$(eval RUN_CONT := $(shell docker ps --quiet))
	@if [ -n "$(RUN_CONT)" ]; then \
      echo "Killing running containers: $(RUN_CONT)"; \
	  docker kill $(RUN_CONT); \
	fi

prune-dangling-images:
	$(eval DANG_IMG := $(shell docker image ls --filter "dangling=true" --quiet))
	@if [ -n "$(DANG_IMG)" ]; then \
      echo "Prune dangling images: $(DANG_IMG)"; \
	  docker image rm -f $(DANG_IMG); \
	fi

prune-pflanzastic-images: 
	$(eval PFL_IMG := $(shell docker image ls --filter "reference=pflanzastic*" --quiet))
	@if [ -n "$(PFL_IMG)" ]; then \
      echo "Prune pflanzastic images: $(PFL_IMG)"; \
	  docker image rm -f $(PFL_IMG); \
	fi

####################
# PROD environment #
####################

install: install-client-elm install-elm-builder
install-client-elm:
	@docker build \
		--target pflanzastic-client-elm \
		--tag pflanzastic-client-elm \
		.

install-elm-builder:
	@docker build \
		--target pflanzastic-prod-elm-builder \
		--tag pflanzastic-prod-elm-builder \
		--build-arg uid=$(UID) \
		--build-arg uname=$(UNAME) \
		--build-arg gid=$(GID) \
		--build-arg gname=$(GNAME) \
		.
build:
	@docker run \
		--rm \
		--name pflanzastic-prod-elm-builder \
		--mount type=bind,source=`pwd`,target=/tmp/code \
		--workdir /tmp/code \
		pflanzastic-prod-elm-builder \
		elm make src/Main.elm --output=./public/assets/elm.js

up:
	@docker-compose up -V -d 

down:
	@docker-compose down

reset: down up


###################
# DEV environment #
###################

dev-install: install-client-elm dev-install-elm-builder

dev-install-elm-builder:
	@docker build \
		--target pflanzastic-dev-elm-builder \
		--tag pflanzastic-dev-elm-builder \
		--build-arg uid=$(UID) \
		--build-arg uname=$(UNAME) \
		--build-arg gid=$(GID) \
		--build-arg gname=$(GNAME) \
		.

dev-up:
	@docker-compose \
		--file docker-compose.yaml \
		--file docker-compose.dev.yaml \
		up -V -d 

dev-down:
	@docker-compose \
		--file docker-compose.yaml \
		--file docker-compose.dev.yaml \
		down

dev-reset: dev-down dev-up
