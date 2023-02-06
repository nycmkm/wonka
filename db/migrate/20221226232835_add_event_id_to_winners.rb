class AddEventIdToWinners < ActiveRecord::Migration[7.0]
  def change
    add_column :winners, :event_id, :bigint
  end
end
