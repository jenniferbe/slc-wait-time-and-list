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
                 :student_course => 'math',
                 :student_email => 'student@email.com',
                  :appointment_type => 'weekly'}

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

    it 'redirects to the sign_up controller' do
      allow(Student).to receive(:where).with(:sid => @params[:student_sid]).and_return([@student])
      allow(Student).to receive(:find).with(@params[:student_sid]).and_return(@student)
      post :create, @params
      expect(response).to redirect_to sign_in_student_path(:id => @student.id,
                                                           :appointment_type => @params[:appointment_type],
                                                           :course => @params[:student_course])

    end
  end

  describe 'when signing up a student it redirects the student to' do
    before :each do
      @id = '923854'
      @action = 'create'

      login_slc
      login_tutor
    end
    it 'scheduled_appointment#create if appointment_type is scheduled' do
      post :sign_in, {:id => @id, :appointment_type => 'scheduled'}
      expect(response).to redirect_to(:controller => 'scheduled_appointments',
                                      :action => @action, :student_id => @id)

    end
    it 'student_queue#create if appointment_type is drop_in' do
      post :sign_in, {:id => @id, :appointment_type => 'drop_in'}
      expect(response).to redirect_to(:controller => 'student_queues',
                                      :action => @action, :id => @id)

    end
    it 'weekly_appointment#create if appointment_type is weekly' do
      post :sign_in, {:id => @id, :appointment_type => 'weekly'}
      expect(response).to redirect_to(:controller => 'weekly_appointments',
                                      :action => @action, :student_id => @id)
    end
  end
end



