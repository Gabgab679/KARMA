class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.string :address
      t.text :description
      t.string :status
      t.references :game, null: false, foreign_key: true
      t.integer :max_players

      t.timestamps
    end
  end
end
