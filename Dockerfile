# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Build Stage
FROM base as build

# Install necessary dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs yarn

# Install RubyGems version that is compatible with ffi (>=3.3.22)
RUN gem update --system 3.3.22

# Install the correct Bundler version (2.5.9 to match lockfile)
RUN gem install bundler -v 2.5.9

# Copy Gemfile and Gemfile.lock for bundle install
COPY Gemfile Gemfile.lock ./

# Run bundle install with the correct settings
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry 3

COPY . .

# Precompile assets (if Webpacker is used)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile || echo "Skipping assets..."

# Final Stage
FROM base

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy over the installed gems and the Rails app
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Set up user and permissions
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER rails:rails

# Set entrypoint and default command
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server"]
