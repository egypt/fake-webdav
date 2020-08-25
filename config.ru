require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative 'server'
require_relative 'rack/fake-ntlm'

use Rack::FakeNTLM

#run Server
run RackDAV::Handler.new(root: './htdocs')
