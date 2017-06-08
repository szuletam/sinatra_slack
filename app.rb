require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  post '/' do
    json = request.body.read
    json.inspect
  end

end
