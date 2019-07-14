class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sharable, polymorphic: true, optional: true
  belongs_to :parent, class_name: "Post",optional: true, touch: true
  has_many :replies, class_name: "Post", foreign_key: "parent_id", dependent: :destroy
  validates :user, presence: true
  has_many :activities , as: :actable, dependent: :delete_all
  mount_uploader :image , ImageUploader

  acts_as_mentioner
  acts_as_likeable

  def is_normal_post?
    ! self.sharable
  end

  after_create do |record|
    #setup a job to delete post after a certain amount of time
    DeletePostJob.set(wait: Rails.configuration.delete_posts_after_x_minutes).perform_later(record.id) unless record.parent
    unless record.parent 
      Activity.create!(:user => record.user, actable: record, verb: "create", target_id: record.user.id)
    else 
      Activity.create!(:user => record.user, actable: record, verb: "create", target_id: record.parent.user.id)
    end
  end
  
  validate do |record| 
    if record.is_normal_post?
      record.errors.add(:content, :presence) if record.image.file.nil? && record.content.blank?
    else 
      record.errors.add(:sharable, :presence) unless record.sharable
    end
  end
end
