class AuthToken < ActiveRecord::Base
  belongs_to :user
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
