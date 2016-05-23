class Project < ActiveRecord::Base
  belongs_to :practicum
  belongs_to :student
end
