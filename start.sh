#!/bin/bash
# Start the development server and inject build number

BUILD_HASH=`git rev-parse --short HEAD`
BUILD_TIME=`date +_%Y%m%d_%H%M%S`
BUILD="$BUILD_HASH$BUILD_TIME"

echo "Starting $1 server $BUILD..."
JEKYLL_ENV=$1 BUILD="$BUILD" bundle exec jekyll serve
