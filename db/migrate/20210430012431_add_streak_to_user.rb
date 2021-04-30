class AddStreakToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :streak, :integer
  end
end
