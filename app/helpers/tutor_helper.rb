module TutorHelper
  def is_admin?
    if current_user.try(:admin?)
      # do something
    end
  end
end
