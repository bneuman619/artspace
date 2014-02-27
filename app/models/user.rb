class User < ActiveRecord::Base
  has_many :admins
  has_many :spaces, through: :admins

  has_many :spaces_created, class_name: "Space", foreign_key: "creator_id"

  has_many :reservations, foreign_key: :renter_id
  has_many :spaces_rented, through: :reservations
end
