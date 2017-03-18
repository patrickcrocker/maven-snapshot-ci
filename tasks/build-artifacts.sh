#!/bin/ash

set -e

cd project

args=""
[ -n "$MAVEN_REPO_MIRROR" ] && args="$args -Drepository.url=$MAVEN_REPO_MIRROR";
[ -n "$MAVEN_REPO_USERNAME" ] && args="$args -Drepository.username=$MAVEN_REPO_USERNAME";
[ -n "$MAVEN_REPO_PASSWORD" ] && args="$args -Drepository.password=$MAVEN_REPO_PASSWORD";

pomVersion=$(printf 'POM_VERSION=${project.version}\n0\n' | ./mvnw help:evaluate | grep '^POM_VERSION' | cut -d = -f 2)
groupId=$(printf 'GROUP_ID=${project.groupId}\n0\n' | ./mvnw help:evaluate | grep '^GROUP_ID' | cut -d = -f 2)
artifactId=$(printf 'ARTIFACT_ID=${project.artifactId}\n0\n' | ./mvnw help:evaluate | grep '^ARTIFACT_ID' | cut -d = -f 2)
localRepository=$(printf 'LOCAL_REPOSITORY=${settings.localRepository}\n0\n' | ./mvnw help:evaluate | grep '^LOCAL_REPOSITORY' | cut -d = -f 2)

./mvnw install $args

cd ..

cp -R $localRepository/${groupId//.//}/$artifactId/$pomVersion/* build-artifacts-output/.

echo $pomVersion > build-artifacts-output/version

if [ -f "build-artifacts-output/maven-metadata-local.xml" ]; then
  cat build-artifacts-output/maven-metadata-local.xml | grep lastUpdated | sed -e 's,.*<lastUpdated>\([^<]*\)</lastUpdated>.*,\1,g' > build-artifacts-output/snapshot
fi
