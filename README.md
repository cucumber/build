![Build](https://github.com/cucumber/build/actions/workflows/build.yaml/badge.svg)

# Cucumber Build

Docker image used to build and release projects in the Cucumber organization.

# Usage

In a cucumber project use the `cucumber/cucumber-build:TAG` image to build
and/or release. You'll find available tags at [Docker Hub](https://hub.docker.com/r/cucumber/cucumber-build/tags).

# Building the image

    make

## Processor Architecture

By default, the `make` script will build just for your local host machine's processor architecture, but you can try building for multiple platforms by specifying the PLATFORMS environment variable.

Before doing this, make sure you've started a multi-platform builder:

    docker buildx create --use

Now try running the build with multiple platforms, e.g.

    PLATFORMS=linux/arm64,linux/amd64 make

# Publishing a new version of the image

The Docker image is published to a public dockerhub repository via an [automated Continuous Deployment workflow](./.github/workflows/release.yaml) running off protected release branches.

To make a release, you make a pull request to a `release/<version>` branch, and wait for a member of the [@cucumber/build](https://github.com/orgs/cucumber/teams/build) team to merge it. Once the PR is merged into the release branch, it will be automatically released.

We have an automated [`pre-release`](https://github.com/cucumber/build/blob/main/.github/workflows/pre-release.yaml) workflow which will create a release pull request as soon as you update the [`CHANGELOG.md`](https://github.com/cucumber/build/blob/main/CHANGELOG.md) file, adding a new version heading. Choose a version number using [semantic versioning](https://semver.org/).

Make sure you have [set up a GPG key](https://docs.github.com/en/github/authenticating-to-github/signing-commits) - all commits to the `main` and `release` branches must be signed.
