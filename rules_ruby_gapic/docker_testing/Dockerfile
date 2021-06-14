# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# A dockerfile that decribes an image that showcases bazel rules for gapic-generator-ruby


FROM buildpack-deps:stretch
## Alternatively, start from buildpack-deps:xenial
## FROM buildpack-deps:xenial
## Alternatively, start from bazel image and install dev tools
## FROM l.gcr.io/google/bazel:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-transport-https

RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends bazel


### Requirement: system has `find` to remove the empty-spaced files

### Requirement: system has `wget` to get the gapic-generator-ruby repo
### Requirement: `tar` and `unzip` are both used to produce packaged built libraries
### Requirement: system has `make` to build ruby
### Requirement: system has `zlib` and `zlib-dev`, `libreadline` and `libreadline-dev`, `openssl` and `openssl-dev`, all needed for rubygems to work
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        tar \
        unzip \
        make \
        zlib1g-dev \
        libreadline-dev \
        libssl-dev \ 
    && rm -rf /var/lib/apt/lists/*

### Requirement: Set the correct locale so Ruby strings default to UTF-8, needed for template engine to work
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -f /var/lib/apt/lists/*_*
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en

# For debug
# RUN apt-get install -y --no-install-recommends \
#         strace \
#         less
#     && rm -rf /var/lib/apt/lists/*

### Get the entrypoint and run
WORKDIR /src

RUN wget https://github.com/googleapis/gapic-generator-ruby/archive/gapic-generator/v0.6.12.tar.gz && \
         tar -xzvf ./v0.6.12.tar.gz && \
         mv gapic-generator-ruby-gapic-generator-v0.6.12/ gapic-generator-ruby

COPY ./docker-entrypoint.sh .

WORKDIR /src/gapic-generator-ruby
ENTRYPOINT /src/docker-entrypoint.sh
