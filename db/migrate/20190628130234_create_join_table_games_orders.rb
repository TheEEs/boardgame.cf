class CreateJoinTableGamesOrders < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :orders do |t|
      # t.index [:game_id, :order_id]
      # t.index [:order_id, :game_id]
    end
  end
end
