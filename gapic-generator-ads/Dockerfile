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
# Builder image.
# Creates /workspace/gapic-generator-ads.gem (and possibly also
# /workspace/gapic-generator.gem if building the base gem from main).
# These gem files are copied into the final runtime image.
##
FROM ruby:2.6-stretch as builder
WORKDIR /workspace

# Copy code from the local directory.
COPY . /workspace/

# Build the base generator from source if the directory is present.
RUN if [ -d tmp/gapic-generator ]; then \
      cd tmp/gapic-generator \
      && gem build -o ../../gapic-generator.gem gapic-generator.gemspec \
    ;fi

# Create a build of the gapic-generator-ads gem from source.
RUN gem build -o gapic-generator-ads.gem gapic-generator-ads.gemspec


##
# Runtime image.
# Installs the generator executables, common protos, and an entrypoint.
##
FROM ruby:2.6-stretch
WORKDIR /workspace

# Install common protos.
COPY --from=gcr.io/gapic-images/api-common-protos:latest /protos/ /workspace/common-protos/

# Copy gems from the builder.
COPY --from=builder /workspace/*.gem /workspace/

# Install the base generator first if it was built from source.
RUN if [ -f gapic-generator.gem ]; then \
      gem install gapic-generator.gem \
      && rm gapic-generator.gem \
    ;fi

# Install the subgenerator and other needed tools.
RUN gem install grpc-tools gapic-generator-ads.gem \
    && rm gapic-generator-ads.gem \
    && mkdir -p --mode=777 /.cache

# Install the entrypoint.
COPY ./docker-entrypoint.sh /workspace/entrypoint.sh
COPY ./config.yml /workspace/config.yml
ENTRYPOINT ["/workspace/entrypoint.sh"]
