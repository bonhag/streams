# TODO: add '/client' instructions for setting up client

require 'sinatra'

#ENV['RACK_ENV'] = "production"

streams = {}

get '/watch/:stream' do
  @stream = params[:stream]
  erb :stream
end

get '/create/:stream' do
  streams[ params[:stream] ] = nil 
end

put '/update/:stream' do
  streams[ params[:stream] ] = request.body.read
  "Image updated successfully."
end

delete '/delete/:stream' do
  streams.delete(params[:stream])
end

get '/streams/*.jpg' do |stream|
  content_type 'image/jpeg'
  streams[ stream ]
end

get '/' do
  @available_streams = streams.keys
  erb :index
end

get '/client/' do
  # instructions for client
  erb :client
end

get '/client' do
  redirect '/client/'
end

