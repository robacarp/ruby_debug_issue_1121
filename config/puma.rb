bind "tcp://0.0.0.0:3000"
environment "development"
threads 1,1
workers nil
preload_app!
