class Role < ApplicationRecord
  has_many :department_users

  def self.manager
    find_by_identifier(:manager)
  end

  def self.event_coordinator
    find_by_identifier(:event_coordinator)
    end

  def self.module_coordinator
    find_by_identifier(:module_coordinator)
  end
end
