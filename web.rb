require 'sinatra'
require 'redcarpet'
require 'json'

helpers do

  def streams
    all_streams = []
    files = Dir.glob("public/streams/*.jpg")
    files.each do |file|
      all_streams << file.sub("public/streams/","").sub(".jpg","")
    end
    all_streams
  end

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

get '/watch/:stream' do
  @name = params[:stream]
  erb :watch
end

get '/create/:stream' do
  stream = params[:stream].gsub(/[^A-Za-z]/, "")
  password = stream
  # return password, and that's all
  password
end

put '/update/:stream' do
  stream = params[:stream]
  if ENV['RACK_ENV'] == "development"
    puts "Recieved request to update #{stream}"
  end
  stream_file = open( File.dirname(__FILE__) + "/public/streams/#{stream}.jpg", 'wb')
  stream_file.write(request.body.read)
  stream_file.close
  if ENV['RACK_ENV'] == "development"
    puts "Stream updated successfully."
  end
end

delete '/delete/:stream' do
  stream = params[:stream]
  # first, delete password entry
  # then, delete file if it exists.
  File.delete( File.dirname(__FILE__) + "/public/streams/#{stream}.jpg" )
end

get '/' do
  @rand_src = nil
  if streams.empty?
    @rand_src = "/no.jpg"
  else
    @rand_src = "/streams/#{streams.shuffle[0]}.jpg"
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

