#!/bin/ash

set -e

version=$(cat framework-version/version)
[ -f "framework-snapshot/snapshot" ] version="$version-SNAPSHOT"

args=""
[ -n "$MAVEN_REPO_MIRROR" ] && args="$args -Drepository.url=$MAVEN_REPO_MIRROR";
[ -n "$MAVEN_REPO_USERNAME" ] && args="$args -Drepository.username=$MAVEN_REPO_USERNAME";
[ -n "$MAVEN_REPO_PASSWORD" ] && args="$args -Drepository.password=$MAVEN_REPO_PASSWORD";

cd framework-git
./mvnw install $args
cd ..

cp -R ~/.m2/repository/com/example/framework/$version/* publish-jars-output/.

ls -al publish-jars-output

cat publish-jars-output/maven-metadata-local.xml
