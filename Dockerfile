FROM ruby:2.5.3
MAINTAINER Ty Walls <tygertec.com>

COPY .docker_config .docker_config

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
#
RUN .docker_config/update_apt_sources.sh \
 && apt-get update \
 && apt-get install -qq -y \
        build-essential \
        nodejs \
        libpq-dev \
        libev-dev \
        postgresql-client-9.6 --fix-missing --no-install-recommends

# Set an environment variable to store where the app is installed inside the image.
#
ENV INSTALL_PATH /runbyonrails
RUN mkdir -p $INSTALL_PATH

# Where will all of these commands be executed from? From the WORKDIR... ¯\_(ツ)_/¯
#
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only updated when they change. Drastically decreases build times.
#
COPY Gemfile Gemfile

# Bundling with binstubs allows us to directly call certain binaries without 'bundle exec'
#
RUN bundle install --binstubs

# Copy files from the current directory to the working directory (WORKDIR)
#
COPY . .

# Precompile assets for production (fake postgres password)
#
RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=supersecuretoken assets:precompile

# Make the latest commit hash available in public
#
COPY public/gitcommit.txt public/gitcommit.txt

# Set the correct file permissions on the public directory
#
RUN chmod -R 755 "$INSTALL_PATH/public"

# Expose static assets through a volume for consumption by his royal nginx-ness
#
VOLUME ["$INSTALL_PATH/public"]

# Engage!
#
CMD puma -C config/puma.rb

