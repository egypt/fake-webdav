require 'bundler/setup'
require_relative 'server'
require_relative 'rack/fake-ntlm'

use Rack::FakeNTLM

run Server
