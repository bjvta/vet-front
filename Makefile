default:
	yarn install

runserver:
	yarn start

frontend:
	@test ! -f /python/bin/python
	docker-compose run \
		--rm \
		--service-ports \
		--no-deps \
		--use-aliases \
		\
		frontend --shell

