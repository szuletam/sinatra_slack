require 'rubygems'
require 'json'
require 'slack'
require 'sinatra/base'

class MyApp < Sinatra::Base

  TOKEN_AUTH = 'xoxp-191364520960-191364521120-194432731184-eff97d58cda967c8d430435231768785'

  post '/' do

    json = request.body.read
    unless json.empty?

      Slack.configure do |config|
        config.token = TOKEN_AUTH
      end
      client = Slack::Web::Client.new
      auth = client.auth_test
      if auth['ok']
        data = JSON.parse(json)
        if data['event']
          event = data['event']
          case event['type']
            when 'channel_created'
              msg = client.chat_postMessage(channel: event['channel']['id'], text: 'Hello Everyone!!', as_user: false, username: 'ultrabot')
              'error sending msg' << msg['error'] unless msg['ok']
            else
              'error event'
          end
        elsif data['type']
          case data['type']
            when 'url_verification'
              data['challenge']
            else
              'error data'
          end
        end
      else
        'auth error' << auth['error']
      end
    end
  end

end
