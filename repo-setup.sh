#! /bin/bash

set -e

if [ ! -d build ]; then
   echo "This should be run in the project directory!" >&2
   exit 1
fi

# Clone (non-bare) layers repositories

# Clone bare layers repositories
mkdir -p layers

