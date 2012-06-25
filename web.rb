require 'sinatra'

get '/' do
  erb :index
end

post '/data' do
  params[:myfile]
end

