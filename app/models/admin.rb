class Admin < ActiveRecord::Base
  belongs_to :administrator, class_name: "User", foreign_key: "administrator_id"
  belongs_to :space
end
