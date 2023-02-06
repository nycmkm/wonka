require "rails_helper"

RSpec.describe Attendee do
  describe "validations" do
    let(:valid_attributes) do
      {
        event_id: 2,
        eventbrite_id: 424_242,
        name: "Herbie Hancock",
        email: "herbie@example.com",
      }
    end

    it "validates presence of event_id" do
      attendee = Attendee.new(valid_attributes.except(:event_id))
      expect(attendee).to be_invalid
      expect(attendee.errors).to include(:event_id)
    end

    it "validates presence of eventbrite_id" do
      attendee = Attendee.new(valid_attributes.except(:eventbrite_id))
      expect(attendee).to be_invalid
      expect(attendee.errors).to include(:eventbrite_id)
    end

    it "validates presence of name" do
      attendee = Attendee.new(valid_attributes.except(:name))
      expect(attendee).to be_invalid
      expect(attendee.errors).to include(:name)
    end

    it "validates presence of email" do
      attendee = Attendee.new(valid_attributes.except(:email))
      expect(attendee).to be_invalid
      expect(attendee.errors).to include(:email)
    end
  end
end
