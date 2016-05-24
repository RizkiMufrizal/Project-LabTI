class User < ActiveRecord::Base
  validates :name, :email, :password_hash, presence: true
  validates :email, email_format: { message: 'Format email salah' }

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end
end
