require 'sinatra'
require 'oauth2'
require 'json'
require 'ruby-debug/debugger'
enable :sessions

def client
  OAuth2::Client.new("BKXbdGRhvAVRTIbXLc55fNaSdbXZcWo3Mu1EHCSR", "TmvWNggiPxipZGB1AhpLYtxI2SDUplwx8egsP7AM", :site => "http://localhost:3000")
end

get "/auth/test" do
  redirect client.auth_code.authorize_url(:redirect_uri => redirect_uri)
end

get '/auth/test/callback' do
  access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
  session[:access_token] = access_token.token
  @message = "Successfully authenticated with the server"
  erb :success
end

get '/yet_another' do
  debugger
  @message = get_response('data.json')
  erb :success
end
get '/another_page' do
  debugger
  @message = get_response('data.json')
  erb :another
end

def get_response(url)
  access_token = OAuth2::AccessToken.new(client, session[:access_token])
  p access_token
  JSON.parse(access_token.get("/api/v1/#{url}").body)
end


def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/auth/test/callback'
  uri.query = nil
  uri.to_s
end