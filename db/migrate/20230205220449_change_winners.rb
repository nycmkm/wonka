class ChangeWinners < ActiveRecord::Migration[7.0]
  def change
    remove_column :winners, :name
    remove_column :winners, :email
    remove_column :winners, :attendee_id

    add_reference :winners, :attendee, null: false, foreign_key: true
  end
end
