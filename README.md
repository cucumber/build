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

0. Make sure you have [set up a GPG key](https://docs.github.com/en/github/authenticating-to-github/ -signing-commits) - all pull requests to the `release` branch must be signed.
1. Choose a version number, using [semantic versioning](https://semver.org/).

```
echo "What's the version number you want to release?"
read VERSION
```

2. Update the version number in the [release.yaml](./.github/workflows/release.yaml) workflow.
3. Update the [CHANGELOG.md](./CHANGELOG.md) file, adding your changes in a section beneath the new release number.
4. Commit and tag:

```
git add . && git commit -S -m "Release v$VERSION"
git tag -s v$VERSION -m "Release v$VERSION"
git push && git push --tags
```

5. Submit a pull request to the protected `release` branch. You'll need to squash the commits if any of them are not signed:

```
git checkout release
git checkout -b release-$VERSION
git merge --squash v$VERSION
git push --set-upstream origin release-$VERSION
gh pr create --title "📦 Release v$VERSION" --body "See diff for details." --base release --head release-$VERSION
```

6. Wait for a member of the [@cucumber/build](https://github.com/orgs/cucumber/teams/build) team to merge your change which will trigger an automatic release.
