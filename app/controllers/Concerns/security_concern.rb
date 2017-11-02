module SecurityConcern
  extend ActiveSupport::Concern

  included do
    before_action :auth_check
  end

  def auth_check
    if(logged_in_tutor? == false and logged_in_app? == false)
      redirect_to app_firewall_path
    end
  end

  def logged_in_tutor?
    if(session["tutorauth"] == true)
      return true
    end
    return false
  end

  def logged_in_app?
    if(session["appauth"] == true)
      return true
    end
    return false
  end
end