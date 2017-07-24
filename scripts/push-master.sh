#!/bin/bash

# This script is for the update of the oe-core and bitbake master
# branches, which are nothing more than replicas from the upstream.

(
    cd layers/oe-core && \
    git push -f git@github.com:WindRiver-OpenSourceLabs/oe-core master:master
)

(
    cd layers/bitbake && \
    git push -f git@github.com:WindRiver-OpenSourceLabs/bitbake master:master
)
