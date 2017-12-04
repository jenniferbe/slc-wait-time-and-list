module AuthentificationHelper
  def login_slc
    session["appauth"] = true
  end
end

RSpec.configure do |config|
  config.include AuthentificationHelper, type: :controller
end