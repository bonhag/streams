require 'rest_client'

host = 'www.pauljohninternetart.info'

puts "Please enter the name of your stream:"
stream = gets.chomp
stream_sanitized = stream.gsub(/[^A-Za-z]/, '')
stream = stream_sanitized

puts "You can watch this stream at http://#{host}/watch/#{stream}"

loop {
  system("./wacaw #{stream}")
  response = RestClient.put "http://#{host}/update/#{stream}",
                            :file => File.new("#{stream}.jpeg", 'rb')
  puts response.code
}

