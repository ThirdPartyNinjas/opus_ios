#!/bin/bash

OPUS_VERSION="1.1"

MIN_VERSION="4.3"

build()
{
	SDK=$1
	ARCH=$2

	SYSROOT=eval xcrun -sdk ${SDK} --show-sdk-path

	rm -rf "opus-${OPUS_VERSION}"
	tar xfz "opus-${OPUS_VERSION}.tar.gz"

	pushd .
	cd "opus-${OPUS_VERSION}"

	export CC="xcrun -sdk ${SDK} clang -arch ${ARCH} -miphoneos-version-min=${MIN_VERSION}"
	export CCAS="xcrun -sdk ${SDK} clang -arch ${ARCH} -miphoneos-version-min=${MIN_VERSION} -no-integrated-as"

	./configure --disable-doc --disable-extra-programs --with-sysroot=$(SYSROOT) --host=arm-apple-darwin
	make

	cp .libs/libopus.a ../temp/libopus_${ARCH}.a

	popd

	rm -rf "opus-${OPUS_VERSION}"
}

rm -rf temp
mkdir temp

build iphoneos armv7
build iphoneos armv7s
build iphoneos arm64
build iphonesimulator i386
build iphonesimulator x86_64

rm -rf lib
mkdir lib

lipo temp/libopus_armv7.a temp/libopus_armv7s.a temp/libopus_arm64.a temp/libopus_i386.a temp/libopus_x86_64.a -create -output lib/libopus.a

rm -rf temp
