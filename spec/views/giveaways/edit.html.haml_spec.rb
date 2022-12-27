require 'rails_helper'

RSpec.describe "giveaways/edit", type: :view do
  before(:each) do
    @giveaway = create(:giveaway)
    assign(:giveaway, @giveaway)
    assign(:events, [])
  end

  it "renders the edit giveaway form" do
    render

    assert_select "form[action=?][method=?]", giveaway_path(@giveaway), "post" do

      assert_select "input[name=?]", "giveaway[name]"
    end
  end
end
