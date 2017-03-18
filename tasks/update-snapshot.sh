#!/bin/sh

set -e # fail fast
set -x # print commands

git clone framework-snapshot update-snapshot-output

if [ -f "publish-jars-output/snapshot" ]; then

  cp publish-jars-output/snapshot update-snapshot-output/snapshot

  cd update-snapshot-output

  git config --global user.email "nobody@concourse.ci"
  git config --global user.name "Concourse"

  git add .
  git commit -m "bump to $(cat snapshot)"
fi
