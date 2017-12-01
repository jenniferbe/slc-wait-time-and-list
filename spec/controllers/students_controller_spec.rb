require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe StudentsController, type: :controller do
  describe 'create' do
    before :each do
      login_slc
      login_tutor
      @params = {:student_first_name => 'Athina',
                 :student_last_name => 'Kaunda',
                 :student_sid => '23636173',
                 :course => 'math',
                 :student_email => 'student@email.ctom',
                 :meet_type => 'drop-in',
                 :domestic_student => nil,
                 :transfer_student => nil,
                 :concurrency_student => nil,
                 :concurrent_institution => nil}

      @student_data = {:first_name => @params[:student_first_name],
                       :last_name => @params[:student_last_name],
                       :sid => @params[:student_sid],
                       :email => @params[:student_email],
                       :domestic_student => @params[:domestic_student],
                       :transfer_student => @params[:transfer_student],
                       :concurrency_student => @params[:concurrency_student],
                       :concurrent_institution => @params[:concurrent_institution]}
      @student = FactoryGirl.build(:student, @student_data)
    end
    it 'checks if the student already exists in the database' do
      @params[:course] = "Other"
      @params[:course_other] = "English R1A"
      expect(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
      post :create, @params
    end
    it 'it creates the student if they do not already exist in the database' do
      allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
      expect(Student).to receive(:create).with(@student_data).and_return(@student)
      post :create, @params
    end

    it 'responds if no meet_type is selected' do
      @params["meet_type"] = nil
      post :create, @params
      expect(flash[:notice]).to be_present
    end

    it 'does not allow repeats in the same line' do
      allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
      expect(Student).to receive(:create).with(@student_data).and_return(@student).twice
      @params["meet_type"] = "scheduled"
      post :create, @params
      post :create, @params
      expect(flash[:notice]).to be_present
    end
  end
end



