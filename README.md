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

The Docker image is published to a public dockerhub repository via an [automated Continuous Deployment workflow](./.github/workflows/release.yaml).

To publish a new version of the image:

1. Make sure you have [set up a GPG key](https://docs.github.com/en/github/authenticating-to-github/signing-commits) - all commits to the `release` branch must be signed.
1. Choose a version number, using [semantic versioning](https://semver.org/).
   ```
   echo "What's the version number you want to release?"
   read VERSION
   ```
1. Update the version number in the [release.yaml](./.github/workflows/release.yaml) workflow.
1. Update the [CHANGELOG.md](./CHANGELOG.md) file, adding your changes in a section beneath the new release number.
1. Commit your changes to `main`
   ```
   git checkout main
   git add . && git commit -S -m "Prepare to release v$VERSION"
   git push
   ```
1. Squash the commits to be released into a single commit, signed by you: (this is in case any of the commits you're releasing were not signed).
   ```
   git checkout release
   git checkout -b release-$VERSION
   git merge --squash main
   git commit -S -m "Release v$VERSION"
   git push --set-upstream origin release-$VERSION
   ```
1. Submit a pull request to the protected `release` branch. You [need to install](https://github.com/cli/cli#installation) the GitHub CLI tool, `gh`.
   ```
   gh pr create --title "📦 Release v$VERSION" --body "See diff for details." --base release --head release-$VERSION
   ```
1. Wait for a member of the [@cucumber/build](https://github.com/orgs/cucumber/teams/build) team to merge your change which will trigger an automatic release.
