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
      allow(StudentRequest).to receive(:find).and_return(StudentRequest)
      #allow(StudentRequest).to receive(:where).and_return(@fake_student_request)
    end
    subject { get 'wait_time', :id => @fake_student_request.id}
    it 'retrieves the students waiting in the queue' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentRequest).to receive(:get_active_queues)
      subject
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

end
