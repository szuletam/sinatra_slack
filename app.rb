require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  post '/' do
    if params['token'] == 'UaXee3dvTLdumHAeeQJKmkjX'
      params.inspect
    else
      params.inspect
    end
  end

end
