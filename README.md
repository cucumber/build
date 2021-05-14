# Cucumber Build

Docker image used to build and release projects in the Cucumber organization.

# Usage

In a cucumber project use the `cucumber/cucumber-build:TAG` image to build
and/or release. You'll find available tags at [Docker Hub](https://hub.docker.com/r/cucumber/cucumber-build/tags).

The secrets needed to make a release can be found in Keybase
and should be mounted into the docker image. For an example see
`docker-run-with-secrets` in the `Makefile`.

# Building the image

    make

# Pushing a new image

Before pushing a new image, update `VERSION` in `Makefile`. Then build it again:

    make

Now start a multi-platform builder:

    docker buildx create --use

Push the image to [Docker Hub](https://hub.docker.com/r/cucumber/cucumber-build/tags):

    make docker-push

Make a git tag:

    git commit -am "Release X.Y.Z"
    git tag X.Y.Z
    git push && git push --tags
