# TODO: add '/client' instructions for setting up client

require 'sinatra'

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

end

#ENV['RACK_ENV'] = "production"

get '/watch/:stream' do
  @stream = params[:stream]
  erb :stream
end

get '/create/:stream' do
  stream = params[:stream]
  stream
end

put '/update/:stream' do
  stream = params[:stream]
  protected!(stream)
  puts "Recieved request to update #{stream}"
  stream_file = open( File.dirname(__FILE__) + "/public/streams/#{stream}.jpg", 'wb')
  stream_file.write(request.body.read)
  stream_file.close
  puts "Stream updated successfully."
end

delete '/delete/:stream' do
  stream = params[:stream]
  protected!(stream)
  File.delete( File.dirname(__FILE__) + "/public/streams/#{stream}.jpg" )
end

get '/' do
  @available_streams = Dir.chdir("public/streams") do
    Dir.glob("*.jpg")
  end 
  erb :index
end

get '/client/' do
  # instructions for client
  erb :client
end

get '/client' do
  redirect '/client/'
end

