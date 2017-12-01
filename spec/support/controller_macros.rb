module ControllerMacros
  def login_tutor
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:tutor]
      tutor = FactoryGirl.create(:tutor)
      sign_in tutor
    end
  end
end