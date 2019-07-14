class Article < ApplicationRecord
  belongs_to :game
  #has_one :user , through: :game
  has_many :posts, as: :sharable
  belongs_to :writer, class_name: :User , foreign_key: :writer_id
  has_many :activities, as: :actable, dependent: :delete_all
  validates :title , presence: true
  validates :content, presence: true

  after_create do |record| 
    Activity.create!(:user => record.writer, actable: record, verb: "create", target_id: record.writer.id)
  end
  after_update do |record| 
    Activity.create!(:user => record.writer, actable: record, verb: "update", target_id: record.writer.id)
  end
end
