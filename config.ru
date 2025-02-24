require "bundler/setup"
require "debug"

run do |env|
  puts "before debugger"
  debugger
  puts "after debugger"
  [200, {}, ["Hello, world!"]]
end
