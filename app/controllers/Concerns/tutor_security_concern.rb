module TutorSecurityConcern
  extend ActiveSupport::Concern

  included do
    before_action :auth_check
  end

  def auth_check
    if(logged_in_tutor? ==false)
      if(controller_name != "students")
        redirect_to new_student_path
      end
    else
      if(controller_name != "student_queues")
        redirect_to '/student_queues'
      end
    end
  end

  def logged_in_tutor?
    if(session["tutorauth"] == true)
      return true
    end
    return false
  end
end