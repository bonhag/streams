require_relative '../streams'
require 'test/unit'
require 'rack/test'

class StreamsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
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
    version = json_response['version']

    assert version >= start_time, "#{version} should be later than #{start_time}"
  end

  # pollute
  def test_should_update_if_no_streams_exist
    post '/stream_should_update', {}, 'HTTP_REFERER' =>
      'http://localhost:4567/watch/coming_to_america'

    json_response = JSON.parse last_response.body
    p json_response
    assert_equal 'no', json_response['answer']
  end

  def _test_my_version_is_earlier_than_latest_version
    put '/streams/shabazz.jpg', 'black up'

    post '/stream_should_update', {:my_version => 0},
      'HTTP_REFERER' => 'http://localhost:4567/watch/shabazz'

    json_response = JSON.parse last_response.body
    assert_equal 'yes', json_response['answer']
  end

  def _test_data_returned_if_new_version_available
    put '/streams/radiohead.jpg', 'in rainbows'

    post '/stream_should_be_updated', {:my_version => 0},
      'HTTP_REFERER' => 'http://localhost:4567/watch/radiohead'

    json_response = JSON.parse last_response.body
    assert_equal json_response['and_here_it_is'], 'in rainbows'
  end

  def test_save_stream_data
    save_stream 'big cat', 'soft and furry'
    stream = load_stream 'big cat'
    assert_equal 'soft and furry', stream[:data]
  end
    
    
end
