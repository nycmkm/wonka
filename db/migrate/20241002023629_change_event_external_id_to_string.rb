class ChangeEventExternalIdToString < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :external_event_id, :string
  end
end
