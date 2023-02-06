require "rails_helper"

RSpec.describe Event do
  describe "validations" do
    let(:valid_attributes) do
      {
        name: "Pluto Keyboard Meetup 2056",
        date: Time.parse("January 1, 2056 3:00pm"),
        eventbrite_id: rand(100_000),
      }
    end

    it "validates uniqueness of eventbrite_id" do
      attributes = valid_attributes.merge(eventbrite_id: 2)

      Event.create!(attributes)

      event = Event.new(attributes)
      expect(event).to be_invalid
      expect(event.errors[:eventbrite_id]).to include("has already been taken")
    end

    it "validates presence of name" do
      event = Event.new(valid_attributes.except(:name))
      expect(event).to be_invalid
      expect(event.errors).to include(:name)
    end

    it "validates presence of date" do
      event = Event.new(valid_attributes.except(:date))
      expect(event).to be_invalid
      expect(event.errors).to include(:date)
    end

    it "validates presence of eventbrite_id" do
      event = Event.new(valid_attributes.except(:eventbrite_id))
      expect(event).to be_invalid
      expect(event.errors).to include(:eventbrite_id)
    end
  end
end
