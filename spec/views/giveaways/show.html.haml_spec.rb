require 'rails_helper'

RSpec.describe "giveaways/show", type: :view do
  before(:each) do
    assign(:giveaway, create(:giveaway))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
