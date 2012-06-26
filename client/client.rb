require 'rest_client'

response = RestClient.put 'http://localhost:4567/update/zone',
                            :file => File.new("capture.jpg", 'rb')

puts response.to_str

