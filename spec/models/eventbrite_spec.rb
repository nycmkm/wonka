require "rails_helper"

RSpec.describe Eventbrite do
  describe "#events" do
    it "returns events for the organization" do
      stub_request(:get, /eventbriteapi.com\/v3\/organizations/).
        to_return(status: 200, body: '{"pagination": {"has_more_items": false}, "events": [{"id": 1234, "name": {"text": "test1"}}, {"id": 2345, "name": {"text": "test2"}}]}', headers: { "Content-Type" => "application/json" })

      events = Eventbrite.new.events

      expect(events.count).to eq(2)
      expect(events.first[:id]).to eq(1234)
    end
  end

  describe "#attendees" do
    it "returns checked-in attendees for a given event" do
      stub_request(:get, "https://www.eventbriteapi.com/v3/events/42/attendees?continuation=sup").
        to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: '{"pagination": {"has_more_items": false}, "attendees": [{"profile": {"name": "Zaphod"}, "checked_in": true}]}',
        )
      stub_request(:get, /eventbriteapi.com\/v3\/events\/42\/attendees\?continuation$/).
        to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: '{"pagination": {"has_more_items": true, "continuation": "sup"}, "attendees": [{"profile": {"name": "Trillian"}, "checked_in": false}, {"profile": {"name": "Arthur"}, "checked_in": true}]}',
        )
      attendees = Eventbrite.new.attendees(42)

      expect(attendees.count).to eq(3)

      expect(attendees[0][:profile][:name]).to eq("Trillian")
      expect(attendees[1][:profile][:name]).to eq("Arthur")
      expect(attendees[2][:profile][:name]).to eq("Zaphod")
    end
  end
end
