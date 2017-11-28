class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def devise_parameter_sanitizer
    if resource_class == Tutor
      Tutor::TutorSanitizer.new(Tutor, :tutor, params)
    else
      super # Use the default one
    end
  end

  private
  #Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    byebug
    if resource_or_scope == :tutor
      new_student_path
    else
      root_path
    end
  end
end
