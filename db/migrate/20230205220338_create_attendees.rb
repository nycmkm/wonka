class CreateAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :attendees do |t|
      t.references :event, null: false, foreign_key: true
      t.bigint :eventbrite_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
