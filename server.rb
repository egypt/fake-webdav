require 'sinatra/base'
require 'sinatra/webdav'
require 'sinatra/reloader'

class Server < Sinatra::Base
  register Sinatra::WebDAV

  options '/*' do
    response.headers['Allow'] = 'OPTIONS, LOCK, DELETE, PROPPATCH, COPY, MOVE, UNLOCK, PROPFIND'
    response.headers['Dav'] = '1, 2'
    response.headers['Ms-Author-Via'] = 'DAV'
  end
 
  propfind '/netlogon/' do
    puts request.env["REMOTE_USER"]
    unless request.env["REMOTE_USER"]
      halt 401, 'Not authorized'
    end
    'wat'
  end

end
