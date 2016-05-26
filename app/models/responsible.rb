class Responsible < ActiveRecord::Base
  validates :name, :phone, presence: true

  has_many :projects
end
