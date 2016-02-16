#!/bin/bash

# Determine path to script
MY_PATH=`dirname "$0"`

cd $MY_PATH/..

# Build and run target

if [ "$1" = "release" ] || [ "$1" = "r" ]
then
	if [ "$2" = "test" ]
	then
		#echo "release test"
		ninja -C build/Release Coati_test && cd bin/test && Release/Coati_test
	elif [ "$2" = "trial" ]
	then
		ninja -C build/Release Coati_trial && cd bin/app && Release/Coati_trial
	elif [ "$2" = "keygen" ]
	then
		#echo "release keygen"
		ninja -C build/Release Coati_license_generator && cd bin/license_generator && Release/Coati_license_generator
	else
		#echo "release app"
		ninja -C build/Release Coati && cd bin/app && Release/Coati
	fi
elif [ "$1" = "debug" ] || [ "$1" = "d" ]
then
	if [ "$2" = "test" ]
	then
		#echo "debug test"
		ninja -C build/Debug Coati_test && cd bin/test && Debug/Coati_test
	elif [ "$2" = "trial" ]
	then
		ninja -C build/Debug Coati_trial && cd bin/app && Debug/Coati_trial
	elif [ "$2" = "keygen" ]
	then
		#echo "debug keygen"
		ninja -C build/Debug Coati_license_generator && cd bin/license_generator && Debug/Coati_license_generator_d
	else
		#echo "debug app"
		ninja -C build/Debug Coati && cd bin/app && Debug/Coati
	fi
elif [ "$1" = "package" ] || [ "$1" = "p" ]
then
		ninja package -C build/Release Coati
		mkdir -p distr && cp build/Release/Coati*.tar.gz distr #&& cp build/Release/Coati*.deb distr
		echo "Packages copied into the distr folder"
else
	echo "no arguments: first argument 'release' or 'debug', second argument 'test' for tests"
fi
