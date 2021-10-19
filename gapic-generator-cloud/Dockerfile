# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##
# Base image.
##
FROM ruby:2.6-buster as base

# Set the correct locale so Ruby strings default to UTF-8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
    && apt-get -y upgrade \
    && apt-get install -y -q --no-install-recommends locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -f /var/lib/apt/lists/*_*
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en


##
# Builder image.
# Creates /workspace/gapic-generator-cloud.gem (and possibly also
# /workspace/gapic-generator.gem if building the base gem from main).
# These gem files are copied into the final runtime image.
##
FROM base as builder
WORKDIR /workspace

# Copy code from the local directory.
COPY . /workspace/

# Build the base generator from source if the directory is present.
RUN if [ -d tmp/gapic-generator ]; then \
      cd tmp/gapic-generator \
      && gem build -o ../../gapic-generator.gem gapic-generator.gemspec \
    ;fi

# Create a build of the gapic-generator-cloud gem from source.
RUN gem build -o gapic-generator-cloud.gem gapic-generator-cloud.gemspec


##
# Runtime image.
# Installs the generator executables, common protos, and an entrypoint.
##
FROM base
WORKDIR /app

# Install common protos.
COPY --from=gcr.io/gapic-images/api-common-protos:latest /protos/ /protos/

# Copy gems from the builder.
COPY --from=builder /workspace/*.gem /app/

# Install the base generator first if it was built from source.
RUN if [ -f gapic-generator.gem ]; then \
      gem install gapic-generator.gem \
      && rm gapic-generator.gem \
    ;fi

# Install the subgenerator and other needed tools.
RUN gem install grpc-tools gapic-generator-cloud.gem \
    && rm gapic-generator-cloud.gem \
    && mkdir -p --mode=777 /.cache

# Install the entrypoint.
ENTRYPOINT ["ruby-cloud-docker-entrypoint"]
