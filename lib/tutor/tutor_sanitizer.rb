class Tutor::TutorSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      permit(:sign_up, keys: [:first_name, :last_name, :sid, :email])
    end
end
