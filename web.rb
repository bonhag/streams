require 'sinatra'

sources = {}

get '/' do
  erb :index
end

get '/watch/:source' do
  @source = params[:source]
  erb :viewer
end

get '/window/:source' do
  content_type 'image/jpeg'
  source = params[:source]
  sources[source]
end

post '/create/:source' do
end

put '/update/:source' do
  source = params[:source]
  fobject = params[:file][:tempfile]
  sources[source] = fobject.read()
end

