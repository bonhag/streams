require 'sinatra'

sources = {}

get '/' do
  erb :index
end

get '/watch/:source' do
  content_type 'image/jpeg'
  source = params[:source]
  open(sources[source], 'rb').read()
end

post '/create/:source' do
end

put '/update/:source' do
  source = params[:source]
  source_sanitized = source.gsub(/[^A-Za-z]/, "")
  f = open("public/#{source_sanitized}.jpg", 'wb')
  the_file_object = params[:file][:tempfile] # this is the file object itself.
  f.write(the_file_object)
  f.close
end

