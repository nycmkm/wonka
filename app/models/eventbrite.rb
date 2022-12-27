class Eventbrite
  BASE_URL = "https://www.eventbriteapi.com/v3".freeze

  class RequestError < StandardError; end

  def events
    path = "/organizations/#{organization_id}/events"
    all_pages(path, :events).map { |e| EventbriteEvent.new(e) }
  end

  def attendees(event_id)
    path = "/events/#{event_id}/attendees"
    all_pages(path, :attendees).filter { |a| a[:checked_in] }.map { |a| EventbriteAttendee.new(a) }
  end

  private

  def organization_id
    ENV.fetch("EVENTBRITE_ORGANIZATION_ID")
  end

  def all_pages(path, key, continuation_token = nil)
    response = HTTP.
      auth("Bearer #{ENV.fetch("EVENTBRITE_API_KEY")}").
      follow.
      get("#{BASE_URL}#{path}", params: { continuation: continuation_token })

    if response.status != 200
      raise RequestError, "Error requesting #{path}: #{response.status}"
    end

    body = FastJsonparser.parse(response.body.to_s)

    result = body[key]

    if body[:pagination][:has_more_items] && body[:pagination][:continuation]
      result += all_pages(path, key, body[:pagination][:continuation])
    end

    result
  end
end
