class ChangeOccuredAtToDate < ActiveRecord::Migration[6.1]
  def change
    change_column :game_events, :occured_at, :date
  end
end
