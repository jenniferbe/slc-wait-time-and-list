require 'rails_helper'
require 'byebug'
require 'helpers/authentification_helper'

RSpec.describe StudentRequestsController, type: :controller do
  describe 'wait time' do
    before(:each) do
      login_slc
      login_tutor
      @fake_student_request = double('StudentRequest', :id => 1, :student_id => 1)
      @fake_student_request2 = double('StudentRequest', :id => 2, :student_id => 2)
      allow(Student).to receive(:where)
      #allow(StudentRequest).to receive(:where).and_return(@fake_student_request)
    end
    subject { get 'wait_time', :id => @fake_student_request.id}
    it 'retrieves the students waiting in the queue' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentRequest).to receive(:where).and_return(StudentRequest)
      allow(StudentRequest).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:sorted_results)).to eq(@fake_results)
    end
    it 'finds the correct wait position' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentRequest).to receive(:where).and_return(StudentRequest)
      allow(StudentRequest).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:wait_pos)).to eq(0)
    end
    it 'calculates the correct wait time' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentRequest).to receive(:where).and_return(StudentRequest)
      allow(StudentRequest).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:wait_time)).to eq(0)
    end
  end

  describe 'view index' do
    before(:each) do
      login_slc
      login_tutor
      @fake_student_request = double('StudentRequest', :id => 1, :student_id => 1)
      @fake_student_request2 = double('StudentRequest', :id => 2, :student_id => 2)
      #allow(StudentRequest).to receive(:where).and_return(@fake_student_request)
    end
    it "properly sort" do
      allow(StudentRequest).to receive(:get_active_queues).and_return(@fake_results)
      expect(assigns([@drop_in_queue, @scheduled_queue, @weekly_queue, @active_sessions])).to eq(@fake_results)
      get :index
    end
    it 'fetches the active sessions' do
      allow(StudentRequest).to receive(:where).and_return(StudentRequest)
      expect(StudentRequest).to receive(:where).with({:status => "active"})
      get :index
    end
    # it 'sorts the active sessions by creation time' do
    #   allow(StudentRequest).to receive(:where).and_return(StudentRequest)
    #   allow(StudentRequest).to receive(:order)
    #   expect(StudentRequest).to receive(:order).with("created_at")
    #   get :index
    # end
    it 'makes the active sessions available to the view' do
      allow(StudentRequest).to receive(:where).and_return(StudentRequest)
      allow(StudentRequest).to receive(:order).and_return(@fake_results)
      expect(assigns(:active_sessions)).to eq(@fake_results)
    end
  end
  
  # describe 'active sessions' do
  #   before(:each) do
  #     login_slc
  #     login_tutor
  #     @fake_student_request = double('StudentRequest', :id => 1, :student_id => 1)
  #     @fake_student_request2 = double('StudentRequest', :id => 2, :student_id => 2)
  #     #allow(StudentRequest).to receive(:where).and_return(@fake_student_request)
  #   end
  #   subject { patch 'activate_session', :id => @fake_student_request.id}
  #   it 'updates the status to active' do
  #     allow(StudentRequest).to receive(:find).and_return(@fake_student_request)
  #     allow(@fake_student_request).to receive(:update).with({:status => "active"})
  #     expect(@fake_student_request).to receive(:update).with({:status => "active"})
  #     subject
  #   end
  #   it 'redirects to the index' do
  #     allow(StudentRequest).to receive(:find).and_return(@fake_student_request)
  #     allow(@fake_student_request).to receive(:update).with({:status => "active"})
  #     subject
  #     expect(response).to redirect_to student_requests_path
  #   end
  # end
  # describe 'finish session' do
  #   before(:each) do
  #     login_slc
  #     login_tutor
  #     @fake_student_request = double('StudentRequest', :id => 1, :student_id => 1)
  #     @fake_student_request2 = double('StudentRequest', :id => 2, :student_id => 2)
  #     #allow(StudentRequest).to receive(:where).and_return(@fake_student_request)
  #   end
  #   subject { patch 'finish_session', :id => @fake_student_request.id}
  #   it 'updates the status to finished' do
  #     allow(StudentRequest).to receive(:find).and_return(@fake_student_request)
  #     allow(@fake_student_request).to receive(:update).with({:status => "finished"})
  #     expect(@fake_student_request).to receive(:update).with({:status => "finished"})
  #     subject
  #   end
  #   it 'redirects to the index' do
  #     allow(StudentRequest).to receive(:find).and_return(@fake_student_request)
  #     allow(@fake_student_request).to receive(:update).with({:status => "finished"})
  #     subject
  #     expect(response).to redirect_to student_requests_path
  #   end
  # end

  # describe 'send email on confirm'
  #
  # end

end
