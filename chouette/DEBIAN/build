#!/bin/bash
ROOT=$(readlink -nf $(dirname $0)/..)
CHOUETTE_HOME=$ROOT/chouette/var/lib/chouette
unset GEM_HOME

if ! [ -d $CHOUETTE_HOME ] 
then

	# chouette command
	cd $ROOT
	if ! [ -f chouette-gui-command-2.4.0.zip ] 
	then
		wget http://maven.chouette.cityway.fr/fr/certu/chouette/chouette-gui-command/2.4.0/chouette-gui-command-2.4.0.zip
	fi
	mkdir -p $ROOT/chouette/usr/local/opt/chouette-command
	unzip -d $ROOT/chouette/usr/local/opt/chouette-command chouette-gui-command-2.4.0.zip

	# service chouette
	mkdir -p $ROOT/chouette/etc/init.d
	cp $ROOT/DEBIAN/chouette.service $ROOT/chouette/etc/init.d/chouette
 
	# chouette
	mkdir -p $ROOT/chouette/etc/default
	cp -a $ROOT/DEBIAN/chouette.default $ROOT/chouette/etc/default/chouette
	mkdir -p  $CHOUETTE_HOME
	cd $CHOUETTE_HOME
	git clone -b V2_4 git://github.com/afimb/chouette2
	cd $CHOUETTE_HOME/chouette2
	bundle install --path vendor/bundle --binstubs vendor/bundle/bin 

fi 

# package
cd $ROOT
cp -a $ROOT/DEBIAN $ROOT/chouette
dpkg-deb --build chouette
