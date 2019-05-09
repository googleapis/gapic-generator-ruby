#!/bin/bash
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

GAPIC_SERVICE_CONFIG=

# enable extended globbing for flag pattern matching
shopt -s extglob

# Parse out options.
while true; do
  case "$1" in
    --gapic-service-config ) GAPIC_SERVICE_CONFIG="configuration=$2"; shift 2;;
    --ruby-gapic* ) echo "Skipping unrecognized ruby-gapic flag: $1" >&2; shift ;;
    --* | +([[:word:][:punct:]]) ) shift ;;
    * ) break ;;
  esac
done

if [ -z "$GAPIC_SERVICE_CONFIG" ]; then
  echo "Required argument --gapic-service-config missing."
  exit 64
fi


protoc --proto_path=/protos/ --proto_path=/in/ \
       --ruby_gapic_out=/out/ \
       --ruby_gapic_opt="$GAPIC_SERVICE_CONFIG" \
       `find /in/ -name *.proto`
