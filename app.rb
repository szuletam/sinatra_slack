require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  post '/' do
    var = params['challenge']
    if params['token'] == 'UaXee3dvTLdumHAeeQJKmkjX'
      var
    else
      var
    end
  end

end
