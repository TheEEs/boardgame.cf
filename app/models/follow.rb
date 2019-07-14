class Follow < Socialization::ActiveRecordStores::Follow
    has_many :activities, as: :actable, dependent: :delete_all
    after_create do |record| 
        Activity.create!(user: record.follower, actable: record, verb: "follow", target_id: record.followable.id)
        #Activity.create!(user: record.followable, actable: record, verb: "followed")
    end
end
