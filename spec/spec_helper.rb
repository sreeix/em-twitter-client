require 'rubygems'
require 'bundler/setup'

ROOT = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift(File.join(ROOT, "lib"))
require 'em/twitter_client'

