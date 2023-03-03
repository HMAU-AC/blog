#!/usr/bin/env sh

set -e

git pull git@github.com:HMAU-AC/blog.git master

hugo


git init
git add .
git commit -m 'auto update'
git push -u origin master
