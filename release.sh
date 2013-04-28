#!/bin/bash

# release lein-as-resource

if [[ $# -lt 3 ]]; then
  echo "usage: $(basename $0) new-version" >&2
  exit 1
fi

previous_version=$1
version=$2
next_version=$3

echo ""
echo "Start release of $version, previous version is $previous_version"
echo ""
echo ""

lein do clean && \
git flow release start $version || exit 1

lein with-profile +release set-version ${version} :previous-version ${previous_version} \
  || { echo "set version failed" >2 ; exit 1; }

echo "Now edit project.clj and README"

$EDITOR project.clj
$EDITOR README.md

echo -n "commiting project.clj, release notes and readme.  enter to continue:" \
&& read x \
&& git add project.clj README.md \
&& git commit -m "Updated project.clj, release notes and readme for $version" \
&& echo -n "Peform release.  enter to continue:" && read x \
&& lein do clean, deploy clojars \
&& rm -f pom.xml \
&& git flow release finish $version \
&& echo "Now push to github. Don't forget the tags!"
