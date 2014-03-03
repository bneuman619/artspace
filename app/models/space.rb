class Space < ActiveRecord::Base
  has_many :admins
  has_many :administrators, through: :admins

  has_many :reservations
  has_many :renters, through: :reservations

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :space_uses
  has_many :uses, through: :space_uses

  has_many :photos

  has_many :availabilities

  scope :title, lambda{ |t| where("title ILIKE ?", "%#{t}%") }    
  scope :rate_less, lambda{ |r|  where("rate <= ?", r.to_i)  }

  def upcoming_reservations
    reservations.where("start_time > ? AND space_id = ?", Date.today, self.id)
  end
end
