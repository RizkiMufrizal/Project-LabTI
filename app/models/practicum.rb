class Practicum < ActiveRecord::Base
  validates :practicum_name, presence: true

  has_many :projects
end
