class ChangeGiveawaysEventIdToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :giveaways, :event_id, :bigint
  end
end
