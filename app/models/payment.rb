class Payment < ActiveRecord::Base

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :stripe_user_id, uniqueness: true


  CLIENT_ID = ENV["ARTSPACE_CLIENT_ID"]
  CLIENT_SECRET_API = ENV["ARTSPACE_SECRET_API_KEY"]
  OPTIONS = {
      :site => 'https://connect.stripe.com',
      :authorize_url => '/oauth/authorize',
      :token_url => '/oauth/token'
  }
  CLIENT = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET_API, OPTIONS)
  

  def self.get_url
    params = {
      :scope => 'read_write'
    }
    CLIENT.auth_code.authorize_url(params)
  end

  
  def self.get_authorization_tokens(code)
    CLIENT.auth_code.get_token(code, :params => {:scope => 'read_write'})
  end
  
end
