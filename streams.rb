require 'sinatra'
require 'kramdown'
require 'json'
require 'haml'

set :all_streams, {}

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

  def new_version? stream_name, current_version
    'no'
  end
end

#ENV['RACK_ENV'] = "production"

# simplify, simplify
#

get '/streams/:id' do
  content_type 'image/jpeg'
  settings.all_streams[params[:id]]
end

put '/streams/:id' do
  content_type :json
  #settings.all_streams[params[:id]] = request.body.read
  # version (time travel)
  {:last_updated => Time.now.to_i}.to_json
end

get '/watch/:id' do
  @name = params[:id]
  @version = Time.new.to_i
  haml :watch
  end
  
get '/create/:stream' do
  nil
end
 
post '/is' do
  content_type :json
  {:answer => 'no'}.to_json
end

get '/check' do
  content_type :json
  # get the name of the stream we're watching
  begin
    what_am_i_watching = request.referrer.split('/')[-1]
  rescue NoMethodError
    puts 'Somebody tried to do something bad'
  end


  # check to see whether there's a new version of that stream
  json_request = JSON.parse request.body.to_s
  current_version = json_request.version
  answer = new_version? what_am_i_watching, current_version
  {:answer => answer}.to_json
end

# Note, these two are duplicates, and, I guess, deprecated.
put '/update/:stream' do
  settings.all_streams[params[:stream]] = request.body.read
end

put '/upload/:id' do
  settings.all_streams[params[:id]] = request.body.read
end

delete '/delete/:stream' do
  nil
end

get '/' do
  @rand_src = nil
  @streams = settings.all_streams
  if settings.all_streams.empty?
    @rand_src = "/no.jpeg"
  else
    @rand_src = "/streams/#{settings.all_streams.shuffle[0]}"
  end
  haml :index, :format => :html5
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

# think about end points
get '/endless' do
  redirect '/endless/'
end

get '/endless/' do
  haml :endless
end

