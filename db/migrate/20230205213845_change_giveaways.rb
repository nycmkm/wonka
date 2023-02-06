class ChangeGiveaways < ActiveRecord::Migration[7.0]
  def change
    rename_column :giveaways, :name, :prize

    add_column :giveaways, :num_winners, :integer
    add_column :giveaways, :drawn, :boolean
  end
end
