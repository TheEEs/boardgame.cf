class AddApprovedToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :approved, :boolean, default: false
  end
end
