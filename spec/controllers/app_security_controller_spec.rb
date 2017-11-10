require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe AppSecurityController, type: :controller do

  describe 'redirect if already logged in' do
    before(:each) do
      login_slc
    end
    it 'redirects if logged in' do
      get :show
      response.should redirect_to new_student_path
    end
  end

  describe 'authentification' do
    it 'checks wrong password' do
      wrong_pass = 'wrong password'
      post :authenticate, {:pass => wrong_pass}
      response.should redirect_to app_firewall_path
    end
    it 'checks if there is a password' do
      wrong_pass = ''
      post :authenticate, {:pass => wrong_pass}
      response.should redirect_to app_firewall_path
    end
    it 'redirects correctly if password is right' do
      right_pass = ENV["slc_password"]
      post :authenticate, {:pass => right_pass}
      response.should redirect_to new_student_path
    end
  end

  describe 'logging out' do
    before(:each) do
      login_slc
      login_tutor
    end
    it 'logs out' do
      post :logout
      expect(session["tutorauth"]).to be(false)
      expect(session["appauth"]).to be(false)
      response.should redirect_to app_firewall_path
    end
  end
end