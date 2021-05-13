NAME      := cucumber/cucumber-build
VERSION   := pr-12.1
DEFAULT_PLATFORM = $(shell [ $$(arch) = "arm64" ] && echo "linux/arm64" || echo "linux/amd64")
PLATFORMS ?= ${DEFAULT_PLATFORM}

default:
	docker buildx build --platform=${PLATFORMS} --tag ${NAME}:latest .
.PHONY: default

local:
	docker buildx build --platform=${PLATFORMS} --tag ${NAME}:latest --load .
.PHONY: local

docker-push: default
	[ -d '../secrets' ] || git clone keybase://team/cucumberbdd/secrets ../secrets
	git -C ../secrets pull
	. ../secrets/docker-hub-secrets.sh \
		&& docker login --username $${DOCKER_HUB_USER} --password $${DOCKER_HUB_PASSWORD} \
		&& docker buildx build --push --platform=${PLATFORMS} --tag ${NAME}:latest --tag ${NAME}:${VERSION} .
.PHONY: docker-push

docker-run: local
	docker run \
	  --volume "${HOME}/.m2/repository":/home/cukebot/.m2/repository \
	  --user 1000 \
	  --rm \
	  -it ${NAME} \
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
	  -it ${NAME} \
	  bash
.PHONY: run-with-secrets
