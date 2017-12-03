require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe TutorsController, type: :controller do
  login_tutor
  before :each do
    @drop_in_filter = {:meet_type => 'drop-in', :status => 'waiting'}
    @scheduled_filter = {:meet_type => 'scheduled', :status => 'waiting'}
    @weekly_filter = {:meet_type => 'weekly', :status => 'waiting'}
    @active_filter = {:status => 'active'}
  end
  describe 'index' do
    before :each do
      allow(Tutor).to receive(:filter_student_requests).with(@drop_in_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@scheduled_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@weekly_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@active_filter)
    end
    
    it 'calls Tutor#filter_student_queue with @drop_in_filter' do
      expect(Tutor).to receive(:filter_student_requests).with(@drop_in_filter)

      post :index

    end
    it 'calls Tutor#filter_student_queue with @schedule_filter' do
      expect(Tutor).to receive(:filter_student_requests).with(@scheduled_filter)

      post :index

    end
    it 'calls Tutor#filter_student_queue with @weekly_filter' do
      expect(Tutor).to receive(:filter_student_requests).with(@weekly_filter)

      post :index
    end
    it 'calls Tutor#filter_student_queue with @weekly_filter' do
      expect(Tutor).to receive(:filter_student_requests).with(@active_filter)

      post :index
    end

  end

  describe 'finish_session' do
    before :each do
      @params = @params = {:id => '238745938'}
      @fake_student_request = StudentRequest.create(:id => @params[:id], :student_id => '1')
    end
    it 'it queries the StudentRequest table' do

      expect(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      # expect(@student_request).to receive(:update).with(:status => 'finished')
      # expect(Tutor).to receive(:session_to_histories)
      # expect(StudentRequest).to receive(:destroy)

      post :finish_session, @params
    end

    it 'it updates with finish' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      expect(@fake_student_request).to receive(:update).with(:status => 'finished')
      post :finish_session, @params
    end

    it 'moves the session to history' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      allow(@fake_student_request).to receive(:update).with(:status => 'finished')
      expect(Tutor).to receive(:session_to_histories)
      post :finish_session, @params
    end

    it 'it destroys the session' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      allow(Tutor).to receive(:session_to_histories)
      expect(StudentRequest).to receive(:destroy).with(@params[:id])
      post :finish_session, @params
    end

    it 'redirects to the tutors_path' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      post :finish_session, @params
      expect(response).to redirect_to tutors_path
    end
  end

  describe 'activate_session' do
    before :each do
      @params = @params = {:id => '238745938'}
      @fake_student_request = StudentRequest.create(:id => @params[:id], :student_id => '1')
    end
    it 'it queries the StudentRequest table' do

      expect(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      # expect(@student_request).to receive(:update).with(:status => 'finished')
      # expect(Tutor).to receive(:session_to_histories)
      # expect(StudentRequest).to receive(:destroy)

      post :activate_session, @params
    end

    it 'it updates with active' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      expect(@fake_student_request).to receive(:update).with(hash_including(:status => 'active'))
      post :activate_session, @params
    end

    it 'sends an email to the student' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      allow(@fake_student_request).to receive(:update).with(hash_including(:status => 'active'))
      expect(StudentRequest).to receive(:send_email_next_in_line)
      post :activate_session, @params
    end

    it 'redirects to the tutors_path' do
      allow(StudentRequest).to receive(:find).with(@params[:id]).and_return(@fake_student_request)
      post :activate_session, @params
      expect(response).to redirect_to tutors_path
    end
  end

  describe 'check in' do
    it 'sets the current tutor to active' do
      expect(@controller.current_tutor.active).not_to eq(true)
      post :check_in
      expect(@controller.current_tutor.active).to eq(true)
    end
  end

  describe 'check out' do
    it 'sets the current tutor to inactive' do
      post :check_in
      expect(@controller.current_tutor.active).to eq(true)
      post :check_out
      expect(@controller.current_tutor.active).to eq(false)
    end
  end
end
