class CreateGameEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :game_events do |t|
      t.string :game_type
      t.datetime :occured_at
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
