require "rails_helper"

RSpec.describe Attendee do
  describe "validations" do
    it { is_expected.to belong_to(:event) }

    it { is_expected.to validate_presence_of(:eventbrite_id) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:email) }
  end
end
