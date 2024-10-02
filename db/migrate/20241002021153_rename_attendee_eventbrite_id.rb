class RenameAttendeeEventbriteId < ActiveRecord::Migration[7.1]
  def change
    rename_column :attendees, :eventbrite_id, :external_id
  end
end
