#!/usr/bin/env sh

set -e

git pull

hugo


git init
git add .
git commit -m 'auto update'
git push -u origin master
