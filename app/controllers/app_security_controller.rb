class AppSecurityController < ApplicationController
  def show
    if(session["appauth"] == true)
      redirect_to new_student_path
    end
  end

  def authenticate
    if(params["pass"])
      if(params["pass"]==Security.app_firewall_password)
        session["appauth"] = true
      end
    end

    redirect_to new_student_path
  end

end