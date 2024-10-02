class RenameEventEventbriteId < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :eventbrite_id, :external_event_id
  end
end
