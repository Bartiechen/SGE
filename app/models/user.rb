class User < ApplicationRecord
  has_many :department_users, dependent: :destroy
  has_many :roles, through: :department_users

  def is_manager?
    is_type?("manager")
  end

  def is_coordinator?
    is_type?("event")
  end

  private

  def is_type?(type)
    self.roles.map(&:flag).include?(type) ? true : false # will return true if the param type is included in the user´s role´s names.
  end
end
