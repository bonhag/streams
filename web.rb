require 'sinatra'
require 'kramdown'
require 'json'

helpers do

  def protected!(stream)
    unless authorized?(stream)
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?(stream)
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [stream, stream]
  end

  def generate_password(length=16)
    chars = [*?a..?z, *?A..?Z, *0..9]
    (1..length).map{ chars.sample }.join
  end

  def stream_reserved?(stream)
    # a stream exists if there is a password set for it
    false
  end
end

#ENV['RACK_ENV'] = "production"

# simplify, simplify
#
set :active_streams, {}

get '/stream/:id' do
  settings.active_streams[params[:id]]
end

put '/stream/:id' do
  settings.active_streams[params[:id]] = request.body.read
end


get '/watch/:stream' do
  @id = params[:stream]
  erb :watch
end

get '/create/:stream' do
  nil
end

put '/update/:stream' do
  puts "update/stream"
  if ENV['RACK_ENV'] == "development"
    puts "Recieved request to update #{stream}"
  end
  File.open("public/streams/#{stream}.jpeg", 'w+') do |file|
    file.write(request.body.read)
  end
  if ENV['RACK_ENV'] == "development"
    puts "Stream updated successfully."
  end
end

put '/upload/:id' do
  puts "/upload/id"
  File.open("public/streams/#{params[:id]}", 'w+') do |file|
    file.write(request.body.read)
  end
end

delete '/delete/:stream' do
  nil
end

get '/' do
  @rand_src = nil
  if streams.empty?
    @rand_src = "/no.jpeg"
  else
    @rand_src = "/streams/#{streams.shuffle[0]}.jpeg"
  end
  erb :index
end

get '/streams.json' do
  streams.to_json
end


get '/client/' do
  # instructions for client
  markdown :client
end

get '/client' do
  redirect '/client/'
end

get '/watch' do
  redirect '/watch/'
end

get '/watch/' do
  redirect '/'
end

get '/endless' do
  redirect '/endless/'
end

get '/endless/' do
  erb :endless
end

