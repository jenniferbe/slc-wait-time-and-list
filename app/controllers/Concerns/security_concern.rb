module SecurityConcern
  extend ActiveSupport::Concern

  included do
    before_action :auth_check
  end

  def auth_check
    if(Security.logged_in_tutor? and Security.logged_in_app?)
      redirect_to '/student_queues'
    elsif(Security.logged_in_tutor? == false and Security.logged_in_app?)
      redirect_to new_student_path
    else
      redirect_to app_firewall_path
    end
  end
end