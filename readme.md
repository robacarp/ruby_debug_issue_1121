# Remote Debugger Failure

This repository is a minimal proof of concept which causes ruby-debug to behave erratically when debugging a remote process.

## Reproduction Steps

1. Clone this repository
2. `bundle install`
3. `./run`
4. visit [localhost:3000](http://localhost:3000)
5. Attach to the remote debugger wiht `rdbg --attach`

## Faulty behavior

```consolesession
> rdbg --attach

DEBUGGER (client): Connected. PID:68188, $0:/Users/robert/.asdf/installs/ruby/3.3.0/bin/puma

[1, 8] in config.ru
     1| require "debug"
     2| 
     3| run do |env|
     4|   puts "before debugger"
=>   5|   debugger
     6|   puts "after debugger"
     7|   [200, {}, ["Hello, world!"]]
     8| end
=>#0	block {|env={"rack.version"=>[1, 6], "rack.errors"=>...|} in <top (required)> (3 levels) at config.ru:5
  #1	Puma::Configuration::ConfigMiddleware#call(env={"rack.version"=>[1, 6], "rack.errors"=>...) at ~/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/configuration.rb:272
  # and 6 frames (use `bt' command for all frames)
(ruby:remote) 1
# No sourcefile available for /Users/robert/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/single.rb
=>#0	[C] Thread#join at ~/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/single.rb:63
  #1	Puma::Single#run at ~/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/single.rb:63
  # and 5 frames (use `bt' command for all frames)

Stop by SIGURG
(ruby:remote) 2
1
(ruby:remote) 3
2
(ruby:remote) 4

^C# No sourcefile available for /Users/robert/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/single.rb
=>#0	[C] Thread#join at ~/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/single.rb:63
4
(rdbg:remote) exit
  #1	Puma::Single#run at ~/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/puma-6.4.3/lib/puma/single.rb:63
  # and 5 frames (use `bt' command for all frames)

Stop by SIGURG
(rdbg:remote) exit
```

