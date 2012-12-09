require_relative '../streams'
require 'test/unit'
require 'rack/test'

class StreamsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # pollute
  def test_no_streams_exist
    post '/is', {:version => Time.now.to_i}
    #, 'HTTP_REFERER' => 'http://localhost:4567/watch/shabazz'
    json_response = JSON.parse last_response.body
    assert_equal json_response['answer'], 'no'
  end

  def test_updating_a_stream
    start_time = Time.now.to_i

    # put, because the same data creates the same _resource_
    # (even if that resource may have different attributes,
    # like when it was last updated)
    put '/streams/radiohead.jpg', 'in rainbows'
    # assert_equal last_request.body.read, 'in rainbows'

    # take a number
    json_response = JSON.parse last_response.body
    last_updated = json_response['last_updated']

    assert last_updated >= start_time, "#{last_updated} should be later than #{start_time}"
  end

  def not_yet
    post '/is', {:stream => 'radiohead', :version => version.to_i - 1}
    json_response = JSON.parse last_response_body

    assert_equal json_response['answer'], 'yes'
    assert_equal json_response['and_here_it_is'], 'in rainbows'
  end

    
end
