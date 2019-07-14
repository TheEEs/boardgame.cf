class AddInfoToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :description, :text
    add_column :games, :numbers_of_player, :integer
    add_column :games, :hardness, :integer
  end
end
