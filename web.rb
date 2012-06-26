require 'sinatra'
require 'sequel'

# Sequel.connect(ENV['DATABASE_URL'])

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
  the_file_object = params[:file][:tempfile] # this is the file object itself.
  sources[source] = File.absolute_path(the_file_object)
end

get '/dbtest' do
  DB = Sequel.connect(ENV['DATABASE_URL'])
end

post '/data' do
  params[:myfile]
end

