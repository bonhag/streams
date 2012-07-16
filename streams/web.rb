require 'sinatra'
require 'maruku'

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

get '/watch/:stream' do
  @stream = params[:stream]
  erb :stream
end

get '/create/:stream' do
  stream = params[:stream].gsub(/[^A-Za-z]/, "")
  password = stream
  # return password, and that's all
  password
end

put '/update/:stream' do
  stream = params[:stream]
  protected!(stream)
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
  protected!(stream)
  # first, delete password entry
  # then, delete file if it exists.
  File.delete( File.dirname(__FILE__) + "/public/streams/#{stream}.jpg" )
end

get '/' do
  jpgs = Dir.chdir("public/streams") do
    Dir.glob("*.jpg")
  end

  @available_streams = []

  jpgs.each { |jpg|
    @available_streams << jpg.sub(".jpg", "")
  }

  erb :index
end

get '/client/' do
  # instructions for client
  markdown :client
end

get '/client' do
  redirect '/client/'
end

