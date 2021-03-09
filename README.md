Cucumber Build
==============

Docker image used to build and release projects in the Cucumber organization.

# Usage

In a cucumber project use the `cucumber/cucumber-build:latest` image to build
and or release.

The secrets needed to make a release can be found in keybase
and should be mounted into the docker image. For an example see
`docker-run-with-secrets` in the `Makefile`.

# Building the image

    docker build --tag cucumber/cucumber-build:latest .

# Pushing a new image

    make docker-push

This will build the image and publish it at https://hub.docker.com/r/cucumber/.
