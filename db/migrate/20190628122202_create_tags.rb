class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :content

      t.timestamps
    end
    add_index :tags, :content, unique: true
  end
end
