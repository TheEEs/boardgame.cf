class AddVerbToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :verb, :string
    #verb can be one of these values 
    # CREATE 
    # UPDATE
    # MENTION
    # MENTIONED
    # LIKE
    # LIKED
    # FOLLOW
    # FOLLOWED
  end
end
