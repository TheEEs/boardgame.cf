class Game < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :posts , as: :sharable
  mount_uploader :image, ImageUploader
  has_many :activities, as: :actable, dependent: :delete_all
  validates :name, presence: true
  validates :price, numericality: {
    :only_integer => true ,
    :greater_than => 0
  }
  validates :hardness , numericality: {
    :only_integer => true,
    :greater_than => 0,
    :less_than_or_equal_to => 5
  }
  validates :numbers_of_player, numericality:{
    :only_integer => true ,
    :greater_than => 0
  }

  after_create do |record| 
    Activity.create!(:user => record.user, actable: record, verb: "create", target_id: record.user.id)
  end

  after_update do |record| 
    Activity.create!(:user => record.user, actable: record, verb: "update", target_id: record.user.id)
  end
end
