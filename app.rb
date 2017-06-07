require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  post '/' do
    var = params.inspect
    if params['token'] == 'UaXee3dvTLdumHAeeQJKmkjX'
      var << 'Hello Men!'
    else
      var << 'Who Are You?'
    end
  end

end
