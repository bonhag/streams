class Stream
  attr_reader :data, :last_updated

  def initialize
    @last_updated = 0
  end

  def data= data
    @data = data
    @last_updated = Time.now
  end
end
