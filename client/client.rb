require 'rest_client'

host = "growing-window-4124.herokuapp.com"

puts "Please enter the name of your source:"
source = gets.chomp
source_sanitized = source.gsub(/[^A-Za-z]/, '')
source = source_sanitized

puts "You can watch this stream at http://#{host}/watch/#{source}"

response = RestClient.put "http://#{host}/update/#{source}",
                            :file => File.new("capture.jpg", 'rb')

puts response.code

