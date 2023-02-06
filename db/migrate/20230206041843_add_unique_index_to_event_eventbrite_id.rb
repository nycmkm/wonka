class AddUniqueIndexToEventEventbriteId < ActiveRecord::Migration[7.0]
  def change
    add_index :events, :eventbrite_id, unique: true
  end
end
