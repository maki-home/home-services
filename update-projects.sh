#!/bin/sh
set -e

pushd income-outcome
git pull origin master
popd

pushd moneygr
git pull origin develop
popd

pushd uaa
git pull origin develop
popd

pushd account
git pull origin develop
popd

git add -A
git commit -m "Update"
git push origin master