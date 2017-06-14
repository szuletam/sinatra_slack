require 'rubygems'
require 'json'
require 'slack'
require 'sinatra/base'

class MyApp < Sinatra::Base

  TOKEN_AUTH = 'xoxp-191364520960-191364521120-194432731184-eff97d58cda967c8d430435231768785'
  TOKEN_VALIDATION = 'UaXee3dvTLdumHAeeQJKmkjX'
  CLIENT_ID = '191364520960.192428893761'

  get '/' do
  "<a href='https://slack.com/oauth/authorize?scope=identity.basic&client_id=#{CLIENT_ID}'><img alt='Sign in with Slack' height='40' width='172' src='https://platform.slack-edge.com/img/sign_in_with_slack.png' srcset='https://platform.slack-edge.com/img/sign_in_with_slack.png 1x, https://platform.slack-edge.com/img/sign_in_with_slack@2x.png 2x' /></a>"
  end

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
            when 'message'
              msg_info = {
                  channel: event['channel'],
                  text: 'Would you like something to eat?',
                  as_user: false,
                  username: 'ultrabot',
                  attachments: [
                      {
                          text: 'Choose a food to eat',
                          fallback: 'You are unable to choose a foot',
                          callback_id: 'wopr_food',
                          color: '#3AA3E3',
                          attachment_type: 'default',
                          actions: [
                              {
                                  name: 'food',
                                  text: 'Hot Dog',
                                  type: 'button',
                                  value: 'hot_dog'
                              },
                              {
                                  name: 'food',
                                  text: 'Pizza',
                                  type: 'button',
                                  value: 'pizza'
                              },
                              {
                                  name: 'food',
                                  text: 'beans',
                                  style: 'danger',
                                  type: 'button',
                                  value: 'war',
                                  confirm: {
                                      title: 'Are you sure?',
                                      text: "Wouldn't you prefer a good Pizza?",
                                      ok_text: 'Yes',
                                      dismiss_text: 'No'
                                  }
                              }
                          ]
                      }
                  ]
              }
              msg = client.chat_postMessage(msg_info) unless event['bot_id']
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

  post '/interactive' do
    json = request.body.read
    unless json.empty?

    end
  end

  get '/redirect' do
    code = params['code']
  end

end
