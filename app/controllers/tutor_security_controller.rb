class TutorSecurityController < ApplicationController
  # before_action :auth_check
  #
  # def auth_check
  #   if(logged_in_app? ==false)
  #     if(controller_name != "app_security")
  #       redirect_to app_firewall_path
  #     end
  #   end
  # end
  #
  # def logged_in_app?
  #   if(session["appauth"] == true)
  #     return true
  #   end
  #   return false
  # end

  include AppSecurityConcern

  def show
    if(session["tutorauth"] == true)
      redirect_to '/student_queues'
    end
  end

  def pass_check
    if(params["pass"]== ENV["tutor_password"])
      session["tutorauth"] = true
      redirect_to '/student_queues'
    else
      flash[:error] = 'Incorrect Password'
      redirect_to tutor_firewall_path
    end
  end

  def authenticate
    if(params["pass"]!= nil and params["pass"] != "")
      pass_check
    else
      flash[:error] = 'Enter a password'
      redirect_to tutor_firewall_path
    end

  end

  def logout
    session["tutorauth"] = false
    redirect_to new_student_path
  end
end