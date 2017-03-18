#!/bin/ash

set -e -x

cd framework-git

args=""
[ -n "$MAVEN_REPO_MIRROR" ] && args="$args -Drepository.url=$MAVEN_REPO_MIRROR";
[ -n "$MAVEN_REPO_USERNAME" ] && args="$args -Drepository.username=$MAVEN_REPO_USERNAME";
[ -n "$MAVEN_REPO_PASSWORD" ] && args="$args -Drepository.password=$MAVEN_REPO_PASSWORD";

pomVersion=`./mvnw help:evaluate -Dexpression=project.version 2>/dev/null | grep -e '^[^\[]'`

echo "pomVersion=$pomVersion"
#./mvnw install $args

cd ..

#cp -R ~/.m2/repository/com/example/framework/$pomVersion/* publish-jars-output/.

#ls -al publish-jars-output

#cat publish-jars-output/maven-metadata-local.xml
