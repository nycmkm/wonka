class EventbriteEvent
  def initialize(attrs)
    @id = attrs["id"]
    @name = attrs["name"]["text"]
  end

  attr_accessor :id, :name
end
