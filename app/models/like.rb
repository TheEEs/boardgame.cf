class Like < Socialization::ActiveRecordStores::Like
    has_many :activities, as: :actable, dependent: :delete_all
    after_create do |record| 
        Activity.create!(user: record.liker, actable: record, verb: "like", target_id: record.likeable.user.id)
        #Activity.create!(user: record.likeable.user, actable: record, verb: "liked")
    end
end
