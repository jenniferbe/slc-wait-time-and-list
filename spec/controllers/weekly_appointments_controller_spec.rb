require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe WeeklyAppointmentsController, type: :controller do
  describe 'create' do
    before :each do
      login_slc
      login_tutor
      @params = {:student_id => '2983457', :course => 'math'}
      @student = FactoryGirl.build(:student, :sid => @params[:student_id])
    end
    it 'looks up the student in the database' do
      expect(Student).to receive(:find).with(@params[:student_id]).and_return(@student)
      post :create, @params
    end
    it 'checks that a scheduled appointment exists before creating one' do
      allow(Student).to receive(:find).with(@params[:student_id]).and_return(@student)
      expect(@student).to receive(:weekly_appointment)
      post :create, @params
    end
    describe 'if student has not already signed in' do
      before :each do
        login_slc
        login_tutor
        allow(Student).to receive(:find).with(@params[:student_id]).and_return(@student)
        allow(@student).to receive(:weekly_appointment).and_return(nil)
      end
      it 'creates a scheduled appointment for student and saves it' do
        expect(@student).to receive(:build_weekly_appointment).with(:course => @params[:course])
        expect(@student).to receive(:save)
        post :create, @params
      end
    end
  end
end

