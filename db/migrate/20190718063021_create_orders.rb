class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.datetime :when
      t.string :guid
      t.references :game, foreign_key: true

      t.timestamps
    end
    add_index :orders, :guid, unique: true
  end
end
