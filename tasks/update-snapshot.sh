#!/bin/bash

set -e

git clone framework-snapshot update-snapshot-output

if [ -f "build-artifacts-output/snapshot" ]; then

  cp build-artifacts-output/snapshot update-snapshot-output/snapshot

  cd update-snapshot-output

  git config --global user.email "nobody@concourse.ci"
  git config --global user.name "Concourse"

  git add .
  git commit -m "bump to $(cat snapshot)"
fi
