# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.4
FROM ruby:${RUBY_VERSION}-slim

WORKDIR /rails

# Environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      libpq-dev \
      libvips \
      nodejs \
      npm \
      curl \
      postgresql-client \
      imagemagick && \
    rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN npm install -g yarn@1.22.19

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Create rails user
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

USER rails

EXPOSE 3000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]