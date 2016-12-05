#!/bin/bash

set -e

. build.conf

git clone ${OSIAM_REPO} osiam
pushd osiam
git checkout ${OSIAM_REF}
./gradlew assemble
popd

git clone ${OSIAM_ADDON_SELF_ADMINISTRATION_REPO} addon-self-administration
pushd addon-self-administration
git checkout ${OSIAM_ADDON_SELF_ADMINISTRATION_REF}
mvn package -DskipTests
popd

git clone ${OSIAM_ADDON_ADMINISTRATION_REPO} addon-administration
pushd addon-administration
git checkout ${OSIAM_ADDON_ADMINISTRATION_REF}
mvn package -DskipTests
popd
