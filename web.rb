require 'sinatra'

ENV['RACK_ENV'] = "production"

streams = {}

get '/' do
  @available_streams = streams.keys
  erb :index
end

put '/upload/*.jpeg' do
  file = Tempfile.new('stream')
  file.write(request.body.read)
  puts "stored temp file in #{file}"
  @stream = params[:splat].first
  puts "the stream is #{@stream}"
  streams[ @stream ] = file
  nil
end

get '/watch' do
  redirect to '/'
end

get '/watch/' do
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

not_found do
  redirect '/'
end

