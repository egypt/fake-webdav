=begin
require 'sinatra/base'
require 'sinatra/reloader'

class Server < Sinatra::Base
  register Sinatra::WebDAV

  enable :sessions

  options '/*' do
    response.headers['Allow'] = 'OPTIONS, LOCK, DELETE, PROPPATCH, COPY, MOVE, UNLOCK, PROPFIND'
    response.headers['Dav'] = '1, 2'
    response.headers['Ms-Author-Via'] = 'DAV'
  end

  propfind '/netlogon/' do
    if !session[:user]
      if request.env["REMOTE_USER"]
        session[:user] = request.env["REMOTE_USER"]
      else
        halt 401, "Not authorized\n"
      end
    end
    %Q(<?xml version="1.0" encoding="utf-8"?><D:multistatus xmlns:D="DAV:"><D:response><D:href>http://#{request.host}/netlogon/</D:href><D:propstat><D:status>HTTP/1.1 200 OK</D:status><D:prop><D:getcontenttype/><D:getlastmodified>#{DateTime.now.new_offset(0).strftime("%a, %-d %b %Y %H:%M:%S GMT")}</D:getlastmodified><D:lockdiscovery/><D:ishidden>0</D:ishidden><D:supportedlock><D:lockentry><D:lockscope><D:exclusive/></D:lockscope><D:locktype><D:write/></D:locktype></D:lockentry><D:lockentry><D:lockscope><D:shared/></D:lockscope><D:locktype><D:write/></D:locktype></D:lockentry></D:supportedlock><D:getetag/><D:displayname>netlogon</D:displayname><D:getcontentlanguage/><D:getcontentlength>0</D:getcontentlength><D:iscollection>1</D:iscollection><D:creationdate>2020-08-23T18:09:20.74Z</D:creationdate><D:resourcetype><D:collection/></D:resourcetype></D:prop></D:propstat></D:response></D:multistatus>)
  end

end
=end
