class Staff::BaseController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'staff/layouts/application'
end
