require 'rubygems'
require 'sinatra/base'

class MyApp < Sinatra::Base

  post '/' do
    if params['token'] == 'UaXee3dvTLdumHAeeQJKmkjX'
      params[:challenge].inspect
    else
      params[:challenge].inspect
    end
  end

end
