require 'rails_helper'

RSpec.describe "giveaways/show", type: :view do
  before(:each) do
    assign(:giveaway, Giveaway.create!(
      name: "Name",
      event_id: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
