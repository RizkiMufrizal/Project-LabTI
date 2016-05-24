class Student < ActiveRecord::Base
  validates :npm, :name, :class, :gender, :address, presence: true

  has_many :projects
end
