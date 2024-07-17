# syntax = docker/dockerfile:experimental

FROM ruby:3.3.4 as base

LABEL fly_launch_runtime="rails"

ARG NODE_VERSION=20.7.0
ARG YARN_VERSION=1.22.19
ARG BUNDLER_VERSION=2.4.20

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

ARG BUNDLE_WITHOUT=development:test
ARG BUNDLE_PATH=vendor/bundle
ENV BUNDLE_PATH ${BUNDLE_PATH}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

RUN mkdir /app
WORKDIR /app
RUN mkdir -p tmp/pids

RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /root/.volta
ENV PATH $VOLTA_HOME/bin:/usr/local/bin:$PATH
RUN volta install node@${NODE_VERSION} yarn@${YARN_VERSION} && \
    gem update --system --no-document && \
    gem install -N bundler -v ${BUNDLER_VERSION}

#######################################################################

# install packages only needed at build time

FROM base as build_deps

ARG BUILD_PACKAGES="git build-essential libpq-dev wget vim curl gzip xz-utils libsqlite3-dev libyaml-dev"
ENV BUILD_PACKAGES ${BUILD_PACKAGES}

RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${BUILD_PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

#######################################################################

# install gems

FROM build_deps as gems

COPY Gemfile* ./
RUN bundle install && rm -rf vendor/bundle/ruby/*/cache

#######################################################################

# install node modules

FROM build_deps as node_modules

COPY package*json ./
COPY yarn.* ./
RUN yarn install

#######################################################################

# install deployment packages

FROM base

ARG DEPLOY_PACKAGES="postgresql-client file vim curl gzip libsqlite3-0"
ENV DEPLOY_PACKAGES=${DEPLOY_PACKAGES}

RUN --mount=type=cache,id=prod-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=prod-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    ${DEPLOY_PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# copy installed gems
COPY --from=gems /app /app
COPY --from=gems /usr/local /usr/local

# copy installed node modules
COPY --from=node_modules /app/node_modules /app/node_modules

#######################################################################

# Deploy your application
COPY . .

ARG GIT_VERSION
ENV GIT_VERSION=$GIT_VERSION

# Adjust binstubs to run on Linux and set current working directory
RUN chmod +x /app/bin/* && \
    sed -i 's/ruby.exe\r*/ruby/' /app/bin/* && \
    sed -i 's/ruby\r*/ruby/' /app/bin/* && \
    sed -i '/^#!/aDir.chdir File.expand_path("..", __dir__)' /app/bin/*

# The following enable assets to precompile on the build server.  Adjust
# as necessary.  If no combination works for you, see:
# https://fly.io/docs/rails/getting-started/existing/#access-to-environment-variables-at-build-time
ENV SECRET_KEY_BASE 1
# ENV AWS_ACCESS_KEY_ID=1
# ENV AWS_SECRET_ACCESS_KEY=1

# Run build task defined in lib/tasks/fly.rake
ARG BUILD_COMMAND="bin/rails fly:build"
RUN ${BUILD_COMMAND}

# Default server start instructions.  Generally Overridden by fly.toml.
ENV PORT 8080
ARG SERVER_COMMAND="bin/rails fly:server"
ENV SERVER_COMMAND ${SERVER_COMMAND}
CMD ${SERVER_COMMAND}
