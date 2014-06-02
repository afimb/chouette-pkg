#!/bin/bash
ROOT=$(readlink -nf $(dirname $0)/..)
CHOUETTE_HOME=$ROOT/chouette2/var/lib/chouette
unset GEM_HOME

if ! [ -d $CHOUETTE_HOME ] 
then

	# chouette command
	if ! [ -f chouette-gui-command-2.4.0.zip ] 
	then
		wget http://maven.chouette.cityway.fr/fr/certu/chouette/chouette-gui-command/2.4.0/chouette-gui-command-2.4.0.zip
	fi
	mkdir -p $ROOT/chouette2/usr/local/opt/chouette-command
	unzip -d $ROOT/chouette2/usr/local/opt/chouette-command chouette-gui-command-2.4.0.zip

	# service chouette
	mkdir -p $ROOT/chouette2/etc/init.d
	cp $ROOT/DEBIAN/chouette2.service $ROOT/chouette2/etc/init.d/chouette2
 
	# chouette2
	mkdir -p  $CHOUETTE_HOME
	cd $CHOUETTE_HOME
	git clone -b V2_4 git://github.com/afimb/chouette2
	cd $CHOUETTE_HOME/chouette2
	bundle install --path vendor/bundle --binstubs vendor/bundle/bin 
	RAILS_ENV=production bundle exec rake assets:clean assets:precompile

fi 

# package
cd $ROOT
cp -a $ROOT/DEBIAN $ROOT/chouette2
dpkg-deb --build chouette2
