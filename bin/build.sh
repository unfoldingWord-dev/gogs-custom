#!/usr/bin/bash

set -e

export GOPATH=/home/git/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH
export GOGSPATH=$GOPATH/src/code.gitea.io/gitea
cd $GOGSPATH

tag=$1

git fetch --all
git pull
cd custom
git pull
cd ..
git tag -a -f $tag -m "Version $tag for unfoldingWord" 
git push -f --tags
#go get -u
make build

cd /home/git
rm -rf releases/$tag
RELEASEPATH=/home/git/releases/$tag/gogs
mkdir -p $RELEASEPATH
cp -R $GOGSPATH/public $RELEASEPATH
cp -R $GOGSPATH/scripts $RELEASEPATH
cp -R $GOGSPATH/templates $RELEASEPATH
cp -R $GOGSPATH/custom $RELEASEPATH
rm -rf $RELEASEPATH/custom/.git $RELEASEPATH/custom/conf/app.ini
cp $GOGSPATH/gitea $GOGSPATH/LICENSE $GOGSPATH/README* $RELEASEPATH
tar -cvzf releases/linux_amd64_$tag.tar.gz -C releases/$tag gogs

export GITHUB_TOKEN="V$tag"

