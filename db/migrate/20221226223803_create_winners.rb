class CreateWinners < ActiveRecord::Migration[7.0]
  def change
    create_table :winners do |t|
      t.string :name
      t.bigint :attendee_id
      t.string :email
      t.references :giveaway, null: false, foreign_key: true

      t.timestamps
    end
  end
end
