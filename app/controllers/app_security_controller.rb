class AppSecurityController < ApplicationController
  def show
    if(session["appauth"] == true)
      redirect_to new_student_path
    end
  end

  def pass_check
    if(params["pass"]==ENV["slc_password"])
      session["appauth"] = true
      redirect_to new_student_path
    else
      flash[:error] = 'Incorrect Password'
      redirect_to app_firewall_path
    end
  end

  def authenticate
    if(params["pass"] != nil and params["pass"] != "")
      pass_check
    else
      flash[:error] = 'Enter a password'
      redirect_to app_firewall_path
    end
  end

  def logout
    session["appauth"] = false
    session["tutorauth"] = false
    redirect_to app_firewall_path
  end
end