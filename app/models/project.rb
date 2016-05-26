class Project < ActiveRecord::Base
  validates :name_project, :name_file, presence: true

  belongs_to :practicum
  belongs_to :student
  belongs_to :responsible
end
