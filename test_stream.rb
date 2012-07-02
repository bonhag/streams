require 'test/unit'
require './stream'

class StreamTestCase < Test::Unit::TestCase
  def setup
    @stream = Stream.new
  end
  def test_file
    assert @stream.file.class == Tempfile,
        "jpeg data is stored in a Tempfile object"
  end
  def test_password_immutability
    p1 = @stream.password
    p2 = @stream.password
    assert p1 == p2,
        "password does not change over time"
  end
  def teardown
    @stream = nil
  end
end

