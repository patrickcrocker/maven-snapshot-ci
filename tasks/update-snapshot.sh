#!/bin/sh

set -e # fail fast
set -x # print commands

git clone framework-snapshot update-snapshot-output

cd update-snapshot-output
version=$(cat maven-metadata-local.xml | xmllint --xpath '/metadata/versioning/lastUpdated/text()' - 2>/dev/null)
echo $version > snapshot

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

git add .
git commit -m "bump to $version"
