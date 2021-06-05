#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /usr/src/app/tmp/pids/server.pid

bundle check || bundle install --jobs 20

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"