module AppSecurityConcern
  extend ActiveSupport::Concern

  included do
    before_action :auth_check
  end

  def auth_check
    if(logged_in_app? ==false)
      if(controller_name != "app_security")
        redirect_to app_firewall_path
      end
    else
      if(controller_name != "students")
        redirect_to new_student_path
      end
    end
  end

  def logged_in_app?
    if(session["appauth"] == true)
      return true
    end
    return false
  end
end