class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
