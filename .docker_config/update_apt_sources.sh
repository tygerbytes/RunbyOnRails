#!/usr/bin/env bash

# Add good sources for postgres
echo deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main > /etc/apt/sources.list.d/pgdg.list
apt-key add ./.docker_config/ACCC4CF8.asc

# Update the sources
# apt-get update
