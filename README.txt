opus_ios
==============================================================================

A build script for compiling libopus for iOS

Configurable variables (at the top of the script):
OPUS_VERSION - Change this if you update to a newer version of libopus
MIN_VERSION - Minimum version of iOS you want to target

Make sure opus-${OPUS_VERSION}.tar.gz is in the same folder as build.sh,
then call ./build.sh from the command line. If all goes well, a fat static
library will be in a folder called "lib" with support for:
 * armv7 - iPhone
 * armv76 - iPhone
 * arm64 - iPhone
 * i386 - iPhoneSimulator
 * x86_64 - iPhoneSimulator