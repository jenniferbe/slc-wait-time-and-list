require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe StudentsController, type: :controller do
  describe 'false auth' do
    it 'it checks if logged in' do
     controller.logged_in_app?.should==false
    end
    it 'checks if redirect properly' do
      get :index
      response.should redirect_to app_firewall_path
    end
  end

  describe 'true auth' do
    before(:each) do
      login_slc
    end
    it 'it checks if logged in' do
      controller.logged_in_app?.should==true
    end
    it 'checks if the student already exists in the database' do
      get :index
      response.should_not redirect_to app_firewall_path
    end
  end
end


