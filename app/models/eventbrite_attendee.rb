class EventbriteAttendee
  def initialize(attrs)
    @id = attrs[:id]
    @checked_in = attrs[:checked_in]
    @email = attrs[:profile][:email]
    @name = attrs[:profile][:name]
  end

  def checked_in?
    !!checked_in
  end

  def has_won?
    # TODO: see if a database entry exists
  end

  def mark_as_winner
    # TODO: make database entry
  end

  attr_accessor :id, :checked_in, :email, :name
end
