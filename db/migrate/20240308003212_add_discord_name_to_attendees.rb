class AddDiscordNameToAttendees < ActiveRecord::Migration[7.1]
  def change
    add_column :attendees, :discord_name, :string
  end
end
