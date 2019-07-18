class Order < ApplicationRecord
  belongs_to :game

  before_validation do |record|
    record.guid = SecureRandom.uuid if record.new_record?
  end

  validate do |record|
    if record.when < DateTime.now 
      record.errors.add(:when,:invalid)
    end
  end

  validates :name , presence: true 
  validates :address , presence: true 

  validates :phone, length: {in: 10..11}, format:{
    with: /\A[0-9]*\z/
  }

  after_create do |record|
    DeleteOrderJob.set(wait: Rails.configuration.delete_order_after).perform_later(record.id)
  end
end
