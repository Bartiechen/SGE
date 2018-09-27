class DepartmentUser < ApplicationRecord
  belongs_to :department
  belongs_to :user
  belongs_to :role
end
