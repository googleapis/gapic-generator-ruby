#!/usr/bin/env bash
# Immediately exit if any command fails.
set -e
(cd "{gemfile_dir}" && \
"{bundle}" install  && \
find {vendor_path} -name "patch 1.diff" -delete && \
find {vendor_path} -type d -name "test mini portile-1.0.0" | while read f ; do rm -rf "$f" ; done )