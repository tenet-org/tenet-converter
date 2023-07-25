#!/usr/bin/env sh

export BASE_PATH="/tenet-converter/"

set -e
npm run build

cd dist

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:tenet-org/tenet-converter.git master:gh-pages

cd -