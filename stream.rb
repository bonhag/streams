require 'tempfile'

class Stream
  attr_reader :name, :password, :tempfile
  def initialize(name)
    @name = name
    @password = "rattlesnakes"
    @tempfile = Tempfile.new("Stream-")
  end
end

