require 'net/ntlm'

module Rack
  class FakeNTLM
    def initialize(app, config = {})
      @app = app
    end

    def call(env)
      if /^(NTLM|Negotiate) (.+)/ =~ env["HTTP_AUTHORIZATION"]

        message = Net::NTLM::Message.decode64($2)

        if message.type == 1
          type2 = Net::NTLM::Message::Type2.new
          return [401, {"WWW-Authenticate" => "NTLM " + type2.encode64}, []]
        end

        if message.type == 3
          user = Net::NTLM::EncodeUtil.decode_utf16le(message.user)
          $stderr.puts user
          env['REMOTE_USER'] = user
        end
      end

      @app.call(env)
    end
  end
end
