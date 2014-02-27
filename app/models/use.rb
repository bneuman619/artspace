class Use < ActiveRecord::Base
  has_many :space_uses
  has_many :spaces, through: :space_uses
end
