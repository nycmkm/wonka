class GiveawayRoller
  def initialize(giveaway, spots, reroll_ids = [])
    @giveaway = giveaway
    @spots = spots
    @reroll_ids = reroll_ids
  end

  def roll
    destroy_rerolls
    pick_winners
    giveaway.winners
  end

  private

  def destroy_rerolls
    if reroll_ids.present?
      giveaway.winners.find(reroll_ids).each(&:destroy)
    end
  end

  def pick_winners
    winners = attendees.sample(spots_to_pick)
    winners.each do |winner|
      giveaway.winners.create!(
        attendee_id: winner.id,
        email: winner.email,
        event_id: giveaway.event_id,
        name: winner.name,
      )
    end
  end

  def spots_to_pick
    # TODO: raise error if this is negative
    spots - giveaway.winners.count
  end

  def attendees
    @attendees ||= Eventbrite.new.attendees(giveaway.event_id)
  end

  attr_accessor :giveaway, :spots, :reroll_ids
end
