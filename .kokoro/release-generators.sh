#!/bin/bash

set -eo pipefail

# Install gems in the user directory because the default install directory
# is in a read-only location.
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

git fetch --tags
git switch gapic-generator/v$GEM_VERSION
toys release perform -v --all=gapic-generator < /dev/null
