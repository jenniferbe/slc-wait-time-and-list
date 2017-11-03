class TutorSecurityController < ApplicationController
  def show
    if(session["tutorauth"] == true)
      redirect_to '/student_queues'
    end
  end

  def authenticate
    if(params["pass"])
      if(params["pass"]== ENV["tutor_password"])
        session["tutorauth"] = true
      end
    end
    redirect_to '/student_queues'
  end

  def logout
    session["tutorauth"] = false
    redirect_to new_student_pathx1
  end
end