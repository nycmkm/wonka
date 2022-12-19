require 'rails_helper'

RSpec.describe "giveaways/new", type: :view do
  before(:each) do
    assign(:giveaway, Giveaway.new(
      name: "MyString",
      event_id: 1
    ))
  end

  it "renders new giveaway form" do
    render

    assert_select "form[action=?][method=?]", giveaways_path, "post" do

      assert_select "input[name=?]", "giveaway[name]"

      assert_select "input[name=?]", "giveaway[event_id]"
    end
  end
end
