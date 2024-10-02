require "rails_helper"

RSpec.describe Event do
  describe "validations" do
    let(:valid_attributes) do
      {
        name: "Pluto Keyboard Meetup 2056",
        date: Time.parse("January 1, 2056 3:00pm"),
        external_event_id: rand(100_000),
      }
    end

    it "validates uniqueness of external_event_id" do
      attributes = valid_attributes.merge(external_event_id: 2)

      Event.create!(attributes)

      event = Event.new(attributes)
      expect(event).not_to be_valid
      expect(event.errors[:external_event_id]).to include("has already been taken")
    end

    it "validates presence of name" do
      event = Event.new(valid_attributes.except(:name))
      expect(event).not_to be_valid
      expect(event.errors).to include(:name)
    end

    it "validates presence of date" do
      event = Event.new(valid_attributes.except(:date))
      expect(event).not_to be_valid
      expect(event.errors).to include(:date)
    end

    it "validates presence of external_event_id" do
      event = Event.new(valid_attributes.except(:external_event_id))
      expect(event).not_to be_valid
      expect(event.errors).to include(:external_event_id)
    end
  end
end
