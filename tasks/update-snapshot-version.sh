#!/bin/sh

set -e # fail fast
set -x # print commands

git clone framework-version update-snapshot-version-output

cd updated-gist
version=$(date +%s)
echo $version > snapshot

git config --global user.email "nobody@concourse.ci"
git config --global user.name "Concourse"

git add .
git commit -m "bump to $version"
