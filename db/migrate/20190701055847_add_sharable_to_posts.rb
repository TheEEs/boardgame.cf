class AddSharableToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :sharable, polymorphic: true
  end
end
