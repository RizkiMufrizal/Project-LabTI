class User < ActiveRecord::Base
  before_create :ecrypt_password
  validates :email, :password_hash, presence: true

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  private

  def ecrypt_password
    self.role = 'ROLE_ADMIN'
    self.enable = true
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password_hash, password_salt)
  end
end
