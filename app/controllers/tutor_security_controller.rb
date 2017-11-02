class TutorSecurityController < ApplicationController
  def show
    if(session["tutorauth"] == true)
      redirect_to '/student_queues'
    end
  end

  def authenticate
    if(params["pass"])
      if(params["pass"]==Security.tutor_firewall_password)
        session["tutorauth"] = true
      end
    end
    redirect_to '/student_queues'
  end
end