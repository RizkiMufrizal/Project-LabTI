class Project < ActiveRecord::Base
  validates :name_project, :responsible_person, :name_file, presence: true

  belongs_to :practicum
  belongs_to :student
end
