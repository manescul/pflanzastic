up: fe-build
	docker-compose up -d 

fe-build:
	elm make src/fe/Pflanzastic.elm --output=public/assets/elm.js

down:
	docker-compose down

reset: down up