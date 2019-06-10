FROM ruby:2.6-stretch

# Add common protos.
COPY --from=gcr.io/gapic-images/api-common-protos:beta /protos/ /protos/

# Add protoc and grpc_ruby_plugin.
RUN gem install grpc-tools

# Add our code to the Docker image.
ADD . /usr/src/gapic-generator-ruby/

WORKDIR /usr/src/gapic-generator-ruby/gapic-generator
RUN gem install bundler
RUN bundle install

# Install the executable within the image.
RUN bundle exec rake install
RUN chmod -R 777 /usr/local/bundle
RUN mkdir /.cache
RUN chmod -R 777 /.cache

# Define the generator as an entry point.
ENTRYPOINT ["/usr/src/gapic-generator-ruby/docker-entrypoint.sh"]
