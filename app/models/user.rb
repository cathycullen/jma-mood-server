class User < ActiveRecord::Base
  has_secure_password
  has_many	:moods
  belongs_to :coach

  def create_token
  	self.reset_token = SecureRandom.hex(32)
  	self.save
  end
end
