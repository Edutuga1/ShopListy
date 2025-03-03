# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.4
# Use a more stable Ruby base image
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Build Stage
FROM base AS build

# Install necessary dependencies and clean up unnecessary files after installing
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    curl \
    wget \
    gcc \
    make \
    libncurses5-dev \
    postgresql-client \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists/*

# Install Yarn manually and specify a version
RUN npm install -g yarn@1.22.19

# Copy Gemfile and Gemfile.lock first
COPY Gemfile Gemfile.lock ./

# Ensure Gemfile.lock is writable
RUN chmod 666 Gemfile.lock

# Install dependencies
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy the rest of the application files
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile || echo "Skipping assets..."

# Final Stage
FROM base

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libvips \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Copy over the installed gems and the Rails app
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Set up user and permissions
RUN useradd -m -s /bin/bash rails && \
    chown -R rails:rails /rails

USER rails

# Set entrypoint and default command
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server"]

# Optional Healthcheck (you can adjust as needed)
HEALTHCHECK --interval=30s --timeout=30s --retries=3 \
  CMD curl --silent --fail http://localhost:3000/ || exit 1
