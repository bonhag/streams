require 'sinatra'

streams = {}

get '/' do
  @available_streams = streams.keys
  erb :index
end

get '/watch' do
  redirect to '/'
end

get '/watch/:stream' do
  @stream = params[:stream]
  erb :viewer
end

get '/window/:stream' do
  content_type 'image/jpeg'
  begin
    streams[ params[:stream] ].rewind()
    streams[ params[:stream] ].read()
  rescue NoMethodError
    nil
  end
end

post '/create/:stream' do
end

put '/update/:stream' do
  streams[ params[:stream] ] = params[:file][:tempfile]
  nil
end

