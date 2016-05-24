class Student < ActiveRecord::Base
  before_create :set_role_enable
  validates :npm, :name, :class, :gender, :address, presence: true

  private

  def set_role_enable
    self.role = 'ROLE_MAHASISWA'
    self.enable = true
  end

  has_many :projects
end
