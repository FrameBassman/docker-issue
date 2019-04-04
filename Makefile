build:
	docker-compose \
		--project-directory=${PWD} \
		--project-name=koles \
		-f docker-compose.yml \
		build ${ARGS}
start:
	docker-compose \
		--project-directory=${PWD} \
		--project-name=koles \
		-f docker-compose.yml \
		up --build

docker-cleanup:
	docker volume rm $$(docker volume ls -qf dangling=true)
	docker rmi $$(docker images -a | grep "^<none>" | awk '{print $$3}')
	docker rmi $$(docker images -a --filter=dangling=true -q)
	docker rm $$(docker ps --filter=status=exited --filter=status=created -q)
	