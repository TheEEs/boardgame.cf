class CreateJoinTableTagsGames < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :tags do |t|
      # t.index [:game_id, :tag_id]
      # t.index [:tag_id, :game_id]
    end
  end
end
