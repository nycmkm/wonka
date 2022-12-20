require 'rails_helper'

RSpec.describe "giveaways/index", type: :view do
  before(:each) do
    user = create(:user)
    sign_in user
    assign(
      :giveaways,
      [
        create(:giveaway, user: user, name: "Name"),
        create(:giveaway, user: user, name: "Name"),
      ]
    )
  end

  it "renders a list of giveaways" do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
