class AddPlaytimeToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :playtime, :integer
  end
end
