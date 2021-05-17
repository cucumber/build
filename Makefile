NAME      := cucumber/cucumber-build
DEFAULT_PLATFORM = $(shell [ $$(arch) = "arm64" ] && echo "linux/arm64" || echo "linux/amd64")
PLATFORMS ?= ${DEFAULT_PLATFORM}

default:
	docker buildx build --platform=${PLATFORMS} --tag ${NAME}:latest .
.PHONY: default

local:
	docker buildx build --platform=${PLATFORMS} --tag ${NAME}:latest --load .
.PHONY: local

docker-push: default
	echo "Deprecated. Please submit a pull request to the `release` branch to have your changes released."
.PHONY: docker-push

docker-run: local
	docker run \
	  --volume "${HOME}/.m2/repository":/home/cukebot/.m2/repository \
	  --user 1000 \
	  --rm \
	  -it ${NAME} \
	  bash
.PHONY:
