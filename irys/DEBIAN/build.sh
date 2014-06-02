#!/bin/bash

ROOT=$(readlink -nf $(dirname $0)/..)
NAME=irys-chouette-server
VERSION=2.2.0

if ! [ -f $NAME-$VERSION-distribution.zip ]
then
	wget http://maven.chouette.cityway.fr/irys/irys-chouette-server/$VERSION/$NAME-$VERSION-distribution.zip
fi

rm -rf $ROOT/$NAME
mkdir -p $ROOT/$NAME/tmp
unzip -d $ROOT/$NAME/tmp  $NAME-$VERSION-distribution.zip

cd $ROOT
cp -a $ROOT/DEBIAN $ROOT/$NAME
dpkg-deb --build $NAME
