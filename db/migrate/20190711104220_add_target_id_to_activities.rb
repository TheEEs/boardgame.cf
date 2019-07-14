class AddTargetIdToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :target, foreign_key: true
  end
end
