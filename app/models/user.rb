class User < ActiveRecord::Base
  has_many :admins, foreign_key: :administrator_id
  has_many :spaces_administrated, through: :admins, source: :space

  has_many :spaces_created, class_name: "Space", foreign_key: "creator_id"

  has_many :reservations, foreign_key: :renter_id
  has_many :rentals, through: :reservations, source: :space

  has_many :payments, foreign_key: :creator_id

  has_secure_password
  validates_presence_of :password, :on => :create

  def upcoming_reservations
  	reservations.where("start_time > ?", Date.today)
  end

  def favorite_spaces
  	spaces = reservations.order(:id).limit(3).collect do |r|
  	  r.space
  	end
    spaces.uniq
  end

  def publishable_key
    self.payments.first.publishable_api_key
  end

  def secret_key
    self.payments.first.secret_api_key
  end
end
