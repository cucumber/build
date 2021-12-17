NAME      := cucumber/cucumber-build
DEFAULT_PLATFORM = $(shell [ $$(arch) = "arm64" ] && echo "linux/arm64" || echo "linux/amd64")
PLATFORMS ?= ${DEFAULT_PLATFORM}
RUN_CMD ?=bash

default: /tmp/.buildx-cache-new/index.json Dockerfile
.PHONY: default

/tmp/.buildx-cache-new/index.json: Dockerfile
	docker buildx build \
		--cache-to="type=local,dest=/tmp/.buildx-cache-new" \
		--cache-from="type=local,src=/tmp/.buildx-cache" \
		--platform=${PLATFORMS} \
		--tag ${NAME}:latest .

local: /tmp/.buildx-cache-new/index.json .local-image
.PHONY: local

docker-run: local
	docker run \
	  --rm \
	  -it ${NAME} \
	  $(1)

.local-image:
	docker buildx build --platform=${PLATFORMS} --tag ${NAME}:latest --load .
	touch $@

clean:
	rm .local-image
.PHONY: clean