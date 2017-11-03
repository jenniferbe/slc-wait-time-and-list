require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'create' do
    before :each do
      @params = {:student_first_name => 'Athina',
                 :student_last_name => 'Kaunda',
                 :student_sid => '23636173',
                 :course => 'math',
                 :student_email => 'student@email.com',
                 :meet_type => 'drop-in'}

      @student_data = {:first_name => @params[:student_first_name],
                       :last_name => @params[:student_last_name],
                       :sid => @params[:student_sid],
                       :email => @params[:student_email]}
      @student = FactoryGirl.build(:student, @student_data)
    end
    it 'checks if the student already exists in the database' do
      expect(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
      post :create, @params
    end
    it 'it creates the student if they do not already exist in the database' do
      allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([])
      expect(Student).to receive(:create).with(@student_data).and_return(@student)
      post :create, @params
    end
    it 'looks up the student if they already exist' do
      allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([@student])
      expect(Student).to receive(:find).with(@params[:student_sid]).and_return(@student)
      post :create, @params
    end
  end
end
