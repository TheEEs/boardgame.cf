class AddWriterToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :writer, index: true
  end
end
