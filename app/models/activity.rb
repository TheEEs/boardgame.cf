class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :actable, polymorphic: true
  belongs_to :target , optional: true, class_name: "User"


  after_create do |record|
    NotificationChannel.broadcast_to(record.target, title: "Chú ý !!", content: "Bạn có thông báo mới")
    record.user.followers(User).each do |follower|
      NotificationChannel.broadcast_to(follower, title: "Chú ý !!", content: "Bạn có thông báo mới")
    end
  end
end
