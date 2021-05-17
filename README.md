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

1. Update the version number in the [release.yaml](./.github/workflows/release.yaml) workflow.
2. Update the [CHANGELOG.md](./CHANGELOG.md) file, adding your changes in a section beneath the new release number.
3. Commit and tag:

```
echo "What's the version number you want to release?"
read VERSION
git add . && git commit -m "Release v$VERSION"
git tag v$VERSION
git push && git push --tags
```

4. Submit a pull request to the `release` branch.

```
gh pr create --title "Release v$VERSION" --base release --head v$VERSION
```

5. Wait for a member of the [@cucumber/build](https://github.com/orgs/cucumber/teams/build) team to merge your change and kick off the release.
