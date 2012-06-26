require 'rest_client'

response = RestClient.put 'http://localhost:4567/update/office',
                            :file => File.new("office.jpg", 'rb')

puts response.to_str

