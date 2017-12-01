module SecurityRedirectHelper
  def auth_check_app
    if(logged_in_app? ==false)
      if(controller_name != "app_security")
        redirect_to app_firewall_path
      end
    end
  end

  def logged_in_app?
    if(session["appauth"] == true)
      return true
    end
    return false
  end

  # def auth_check_tutor
  #   if(logged_in_tutor? ==false)
  #     if(controller_name != "students")
  #       redirect_to new_student_path
  #     end
  #   end
  # end
#
#   def logged_in_tutor?
#     if(session["tutorauth"] == true)
#       return true
#     end
#     return false
#   end
 end