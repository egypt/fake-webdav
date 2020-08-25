require 'sinatra/base'
require 'sinatra/webdav'

class Server < Sinatra::Base
  register Sinatra::WebDAV

  propfind '/netlogon/' do
    'wat'
  end

end
