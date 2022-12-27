class Eventbrite
  include HTTParty
  base_uri "https://www.eventbriteapi.com/v3"

  def initialize
    self.class.headers "Authorization" => "Bearer #{ENV.fetch("EVENTBRITE_API_KEY")}"
  end

  def events
    path = "/organizations/#{organization_id}/events"
    all_pages(path, "events").map { |e| EventbriteEvent.new(e) }
  end

  def attendees(event_id)
    path = "/events/#{event_id}/attendees"
    all_pages(path, "attendees").filter { |a| a["checked_in"] }.map { |a| EventbriteAttendee.new(a) }
  end

  private

  def organization_id
    ENV.fetch("EVENTBRITE_ORGANIZATION_ID")
  end

  def all_pages(path, key, continuation_token = nil)
    response = self.class.get(path, query: { continuation: continuation_token })

    result = response[key]

    if response["pagination"]["has_more_items"] && response["pagination"]["continuation"]
      result += all_pages(path, key, response["pagination"]["continuation"])
    end

    result
  end
end
