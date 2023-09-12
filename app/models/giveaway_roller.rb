class GiveawayRoller
  class InvalidReRollError < StandardError; end
  class NegativeSpotsError < StandardError; end

  def initialize(giveaway, reroll_ids = [])
    @giveaway = giveaway
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
      Winner.transaction do
        reroll_ids.each do |id|
          winner = giveaway.winners.find_by(id:)

          if winner.nil?
            raise InvalidReRollError, "Could not find giveaway winner with id #{id}"
          end

          winner.destroy
        end
      end
    end
  end

  def pick_winners
    winners = event.attendees.where.not(id: previous_winners).random.limit(spots_to_pick)

    winners.each do |winner|
      giveaway.winners.create!(
        attendee_id: winner.id,
        event_id: event.id,
      )
    end
  end

  def spots_to_pick
    spots = giveaway.num_winners - giveaway.winners.count

    if spots < 0
      raise NegativeSpotsError, "Rolling would have a negative number of spots"
    end

    spots
  end

  def event
    @event ||= giveaway.event
  end

  def previous_winners
    event.winners.pluck(:attendee_id)
  end

  attr_accessor :giveaway, :reroll_ids
end
