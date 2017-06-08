require 'rubygems'
require 'json'
require 'sinatra/base'

class MyApp < Sinatra::Base

  post '/' do
    json = request.body.read
    data = JSON.parse(json)
    if data['type'] === 'url_verification'
      data['challenge']
    end
  end

end
