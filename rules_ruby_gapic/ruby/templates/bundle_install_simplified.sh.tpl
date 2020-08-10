#!/usr/bin/env bash
# Immediately exit if any command fails.
set -e
"{bundle}" install
find export/bundle -name "patch 1.diff" -delete
find export/bundle -type d -name "test mini portile-1.0.0" | while read f ; do rm -rf "$f" ; done