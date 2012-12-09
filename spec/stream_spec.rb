require_relative '../stream'

describe Stream do
  it "is basically just a holder for image data" do
    stream = Stream.new
    stream.data = 'black awareness'
    stream.data.should == 'black awareness'
  end

  it "keeps track of the last time it was updated" do
    stream = Stream.new
    before_update = Time.now
    stream.data = 'donations'
    after_update = Time.now
    stream.last_updated.should >= before_update
    stream.last_updated.should <= after_update
  end
end

