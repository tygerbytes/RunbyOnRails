
# Bind to a specific TCP address, or listen on specific port?
# It depends on whether or not Rails is running in a container.
#
if ENV['RAILS_CONTAINERIZED'] || false

  # Listen on a specific TCP address. We won't bother using unix sockets because
  #  nginx will be running in a different Docker container.

  bind "tcp://#{ENV.fetch('PUMA_LISTEN_ON') || '0.0.0.0:3000'}"

else
  # Listen on the configured port, or default to 3000.
  # Heroku sets a random port.

  port ENV.fetch('PORT') || 3000
end

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
min_threads = Integer(ENV.fetch('PUMA_MIN_THREADS') || 1 )
max_threads = Integer(ENV.fetch('PUMA_MAX_THREADS') || 5 )
threads min_threads, max_threads

# Specifies the `environment` that Puma will run in.
#
#  environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# An internal health check to verify that workers have checked in to the master
# process within a specific time frame. If this time is exceeded, the worker
# will automatically be rebooted. Defaults to 60s.
#
# Under most situations you will not have to tweak this value, which is why it
# is coded into the config rather than being an environment variable.
#
worker_timeout 30

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Allow puma to be restarted by `rails restart` command.
#
plugin :tmp_restart

