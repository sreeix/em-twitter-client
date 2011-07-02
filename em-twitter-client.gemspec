# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "em-twitter-client/version"

Gem::Specification.new do |s|
  s.name        = "em-twitter-client"
  s.version     = EM::TwitterClient::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["V Sreekanth"]
  s.email       = ["sreeix@gmail.com"]
  s.summary     = %q{Event Machined API to access twitter via rest}
  s.description = %q{Event Machined API to access twitter via rest}

  s.rubyforge_project = "em-twitter-client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ["lib"]
  
  
  s.add_dependency('eventmachine', ">=1.0.0.beta.3")
  s.add_dependency('yajl-ruby')
  s.add_dependency('addressable', ">= 2.2.3")
  s.add_dependency('em-synchrony')
  s.add_dependency('em-http-request', "=1.0.0.beta.4")
  s.add_development_dependency('rspec')
  s.add_development_dependency('rspec-core')
  s.add_development_dependency('rake')
  s.add_development_dependency('bundler')
end
