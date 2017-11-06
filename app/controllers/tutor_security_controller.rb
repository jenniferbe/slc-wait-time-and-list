class TutorSecurityController < ApplicationController
  def show
    if(session["tutorauth"] == true)
      redirect_to '/student_queues'
    end
  end

  def authenticate
    if(params["pass"]!= nil and params["pass"] != "")
      if(params["pass"]== ENV["tutor_password"])
        session["tutorauth"] = true
        redirect_to '/student_queues'
      else
        flash[:error] = 'Incorrect Password'
        redirect_to tutor_firewall_path
      end
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