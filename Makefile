NAME    := cucumber/cucumber-build
TAG     := 0.1.0
IMG     := ${NAME}:${TAG}
LATEST  := ${NAME}:latest

build:
	docker buildx build --rm --tag ${IMG} .
.PHONY: default

docker-push: default
	docker buildx build --tag ${IMG} --tag ${LATEST}
	[ -d '../secrets' ] || git clone keybase://team/cucumberbdd/secrets ../secrets
	git -C ../secrets pull
	. ../secrets/docker-hub-secrets.sh \
		&& docker login --username $${DOCKER_HUB_USER} --password $${DOCKER_HUB_PASSWORD} \
		&& docker push ${IMG} \
		&& docker push --all-tags ${NAME} \
.PHONY: docker-push

docker-run: default
	docker run \
	  --volume "${HOME}/.m2/repository":/home/cukebot/.m2/repository \
	  --user 1000 \
	  --rm \
	  -it ${IMG} \
	  bash
.PHONY:

docker-run-with-secrets: default
	[ -d '../secrets' ]  || git clone keybase://team/cucumberbdd/secrets ../secrets
	git -C ../secrets pull
	docker run \
	  --volume "${shell pwd}":/app \
	  --volume "${shell pwd}/../secrets/import-gpg-key.sh":/home/cukebot/import-gpg-key.sh \
	  --volume "${shell pwd}/../secrets/codesigning.key":/home/cukebot/codesigning.key \
	  --volume "${shell pwd}/../secrets/.ssh":/home/cukebot/.ssh \
	  --volume "${shell pwd}/../secrets/.gem":/home/cukebot/.gem \
	  --volume "${shell pwd}/../secrets/.npmrc":/home/cukebot/.npmrc \
	  --volume "${HOME}/.m2/repository":/home/cukebot/.m2/repository \
	  --env-file ../secrets/secrets.list \
	  --user 1000 \
	  --rm \
	  -it cucumber/cucumber-build:latest \
	  bash
.PHONY: docker-run-with-secrets
