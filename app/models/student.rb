class Student < ActiveRecord::Base
  before_create :set_role_enable
  validates :npm, :name, :class_name, :gender, :address, presence: true

  def self.authenticate(npm, password)
    student = Student.where(npm: npm).first
    if student && student.password_hash == BCrypt::Engine.hash_secret(password, student.password_salt)
      student
    end
  end

  private

  def set_role_enable
    self.role = 'ROLE_MAHASISWA'
    self.enable = true
  end

  has_many :projects
end
