require 'rubygems'
require 'sinatra'
require 'oauth2'
require 'json'
require 'haml'

FACEBOOK_API_KEY = "434277789963565"
FACEBOOK_SECRET_KEY = "c1fbb1ba39c323c8d315e5d13ff36ec1"

enable :sessions

before do
  @client = OAuth2::Client.new(FACEBOOK_API_KEY, FACEBOOK_SECRET_KEY,
                               :site => "https://graph.facebook.com",
                               :scheme => :header,
                               :http_method => :post,
  )
end

get '/' do
  haml :index, :locals => {
      :url => @client.web_server.authorize_url(:redirect_uri => auth_url)
  }
end

get '/auth' do

  access_token = @client.web_server.get_access_token(
      params[:code], :redirect_uri => auth_url
  )

  session[:profile] = JSON.parse(
      access_token.get('/me?fields=picture')
  )

  redirect '/profile'
end

get '/profile' do

  if session[:profile]
    haml :profile, :locals => {:profile => session[:profile]}
  else
    redirect '/'
  end

end

def auth_url

  uri = URI.parse(request.url)
  uri.path = '/auth'
  uri.query = nil
  uri.to_s

end
