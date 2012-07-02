# TODO: add '/client' instructions for setting up client

require 'sinatra'
require './stream'

#ENV['RACK_ENV'] = "production"

streams = {}

get '/watch/:stream' do
  @name = params[:stream]
  erb :stream
end

get '/streams' do
  streams
end

get '/create/:stream' do
  @stream = Stream.new(params[:stream])
  if streams[ @stream.name ].class == Stream
    "Someone is already broadcasting from '#{@stream.name}'."
  else
    streams[ @stream.name ] = @stream
    "Successfully created '#{@stream.name}' with password '#{@stream.password}'"
  end
end

put '/update/:stream' do
  use Rack::Auth::Basic do |username, password|
    @stream = streams[ params[:stream] ]
    if password == @stream.password
      "Stream updated."
    else
      "ERROR: Incorrect password."
    end
  end
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

get '/streams/*.jpg' do
  content_type 'image/jpeg'
  begin
    streams[ params[:stream] ].rewind()
    streams[ params[:stream] ].read()
  rescue NoMethodError # no stream of this name exists
    "No stream called #{params[:stream]} exists. You can create one!"
  end
end

not_found do
  redirect '/'
end

