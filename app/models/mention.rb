class Mention < Socialization::ActiveRecordStores::Mention
    has_many :activities, as: :actable, dependent: :delete_all
    after_create do |record| 
        Activity.create!(user: record.mentioner.user, actable: record, verb: "mention", target_id: record.mentionable.id)
        #Activity.create!(user: record.mentionable, actable: record,verb: "mentioned")
    end
end
