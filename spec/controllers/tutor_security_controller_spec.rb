require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe TutorSecurityController, type: :controller do
  describe 'false auth' do
    it 'it checks if logged in' do
      controller.logged_in_app?.should==false
    end
    it 'checks if redirect properly' do
      get :show
      response.should redirect_to app_firewall_path
    end
  end

  describe 'true auth for slc' do
    before(:each) do
      login_slc
    end
    it 'it checks if logged in' do
      controller.logged_in_app?.should==true
    end
    it 'checks that app should not redirect logged into slc' do
      get :show
      response.should_not redirect_to app_firewall_path
    end
  end

  describe 'true auth for tutor' do
    before(:each) do
      login_slc
      login_tutor
    end
    it 'checks if the should rediret to StudentRequests' do
      get :show
      response.should redirect_to '/student_requests'
    end
  end

  describe 'authentification' do
    before(:each) do
      login_slc
    end
    it 'checks wrong password' do
      wrong_pass = 'wrong password'
      post :authenticate, {:pass => wrong_pass}
      response.should redirect_to tutor_firewall_path
    end
    it 'checks if there is a password' do
      wrong_pass = ''
      post :authenticate, {:pass => wrong_pass}
      response.should redirect_to tutor_firewall_path
    end
    it 'redirects correctly if password is right' do
      right_pass = ENV["tutor_password"]
      post :authenticate, {:pass => right_pass}
      response.should redirect_to '/student_requests'
    end
  end

  describe 'logging out' do
    before(:each) do
      login_slc
      login_tutor
    end
    it 'logs out' do
      expect(controller.logged_in_tutor?).to be(true)
      post :logout
      expect(session["tutorauth"]).to be(false)
      expect(controller.logged_in_tutor?).to be(false)
      response.should redirect_to new_student_path
    end
  end
end