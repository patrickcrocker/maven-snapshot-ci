#!/bin/ash

set -e

#version=$(cat version/version)

#args="-DversionNumber=$version"
args=""
[ -n "$MAVEN_REPO_MIRROR" ] && args="$args -Drepository.url=$MAVEN_REPO_MIRROR";
[ -n "$MAVEN_REPO_USERNAME" ] && args="$args -Drepository.username=$MAVEN_REPO_USERNAME";
[ -n "$MAVEN_REPO_PASSWORD" ] && args="$args -Drepository.password=$MAVEN_REPO_PASSWORD";

cd framework-git
./mvnw install $args
cd ..

cp -R ~/.m2/repository/com/example/framework/1.0.0-SNAPSHOT/* publish-jars-output/.

ls -al publish-jars-output
