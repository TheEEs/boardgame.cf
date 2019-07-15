class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 
  if Rails.env.production? 
    devise :confirmable
  end 
  has_many :games,dependent: :destroy 
  has_many :posts, dependent: :destroy
  has_many :articles, class_name: :Article , foreign_key: :writer_id
  has_many :activities, dependent: :delete_all
  mount_uploader :avatar, AvatarUploader
  

  before_validation do |record|
    record.name = record.name&.strip 
  end

  validates :name, presence: true, format:{
    with: /\A[0-9A-Za-z_.]+\z/,
    message:'can contains only number, alphabet characters, dot(.) and underscore(_)'
  }
  validates :phone, format:{
    with: /\A[0-9]+\z/
  }, length: {in: 10..11}

  def get_activities 
    followee_ids = self.followees(User).select{|user| user.id }
    followee_ids << self.id
    Activity.where(user_id: followee_ids).or(Activity.where(target_id: self.id)).order(:created_at => :desc)
  end

  acts_as_follower
  acts_as_followable
  acts_as_mentionable
  acts_as_liker
end
