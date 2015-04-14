class User < ActiveRecord::Base
  has_secure_password
  has_many :moods, -> {
  	order('created_at DESC')},
  		:dependent =>
  		:destroy)
  }
  belongs_to :coach
  has_many :auth_tokens

  def create_token
    self.reset_token = SecureRandom.hex(32)
    self.save
  end
end
