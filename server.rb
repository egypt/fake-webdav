require 'sinatra/base'
require 'sinatra/webdav'
require 'sinatra/reloader'

class Server < Sinatra::Base
  register Sinatra::WebDAV

  propfind '/netlogon/' do
    puts request.env["REMOTE_USER"]
    unless request.env["REMOTE_USER"]
      halt 401, 'Not authorized'
    end
    'wat'
  end

end
