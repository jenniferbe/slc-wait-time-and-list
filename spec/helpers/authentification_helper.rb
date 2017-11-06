module AuthentificationHelper
  def login_slc
    session["appauth"] = true
  end
  def login_tutor
    session["tutorauth"] = true
  end
end

RSpec.configure do |config|
  config.include AuthentificationHelper, type: :controller
end