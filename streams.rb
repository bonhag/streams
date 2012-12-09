require 'sinatra'
require 'kramdown'
require 'json'
require 'haml'

set :streams, {}

def save_stream id, data
  settings.streams[id] = {:data => data, :version => Time.now.to_i}
  settings.streams[id][:version]
end

def load_stream id
  settings.streams[id]
end

#ENV['RACK_ENV'] = "production"

# simplify, simplify
#

get '/streams/:id' do
  content_type 'image/jpeg'
  stream = load_stream params[:id]
  stream.data
end

put '/streams/:id' do
  content_type :json
  version = save_stream params[:id], request.body.read

  # version (time travel)
  {:version => version}.to_json
end

get '/watch/:id' do
  haml :watch
  end
  
post '/stream_should_update' do
  content_type :json
  my_version = params[:version]

  id = request.referrer.split('/')[-1]
  stream = load_stream id
  return {:answer => 'no'}.to_json unless stream && my_version < stream[:version]

  {:answer => 'yes'}.to_json
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

