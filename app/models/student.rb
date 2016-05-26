class Student < ActiveRecord::Base
  before_create :ecrypt_password
  validates :npm, :name, :class_name, :gender, :address, presence: true

  def self.authenticate(npm, password)
    student = Student.where(npm: npm).first
    if student && student.password_hash == BCrypt::Engine.hash_secret(password, student.password_salt)
      student
    end
  end

  private

  def ecrypt_password
    self.role = 'ROLE_MAHASISWA'
    self.enable = true
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password_hash, password_salt)
  end

  has_many :projects
end
