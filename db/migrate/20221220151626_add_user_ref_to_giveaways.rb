class AddUserRefToGiveaways < ActiveRecord::Migration[7.0]
  def change
    add_reference :giveaways, :user, null: false, foreign_key: true
  end
end
