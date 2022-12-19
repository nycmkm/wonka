require 'rails_helper'

RSpec.describe "giveaways/edit", type: :view do
  let(:giveaway) {
    Giveaway.create!(
      name: "MyString",
      event_id: 1
    )
  }

  before(:each) do
    assign(:giveaway, giveaway)
  end

  it "renders the edit giveaway form" do
    render

    assert_select "form[action=?][method=?]", giveaway_path(giveaway), "post" do

      assert_select "input[name=?]", "giveaway[name]"

      assert_select "input[name=?]", "giveaway[event_id]"
    end
  end
end
