require 'rest_client'

response = RestClient.put 'http://localhost:4567/update/office',
                            :file => File.new("capture.jpg", 'rb')

puts response.code

