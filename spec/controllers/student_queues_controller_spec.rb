require 'rails_helper'
require 'byebug'
require 'helpers/authentification_helper'

RSpec.describe StudentQueuesController, type: :controller do
  describe 'wait time' do
    before(:each) do
      login_slc
      login_tutor
      @fake_student_request = double('StudentQueue', :id => 1, :student_id => 1)
      @fake_student_request2 = double('StudentQueue', :id => 2, :student_id => 2)
      allow(Student).to receive(:where)
      #allow(StudentQueue).to receive(:where).and_return(@fake_student_request)
    end
    subject { get 'wait_time', :id => @fake_student_request.id}
    it 'retrieves the students waiting in the queue' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:sorted_results)).to eq(@fake_results)
    end
    it 'finds the correct wait position' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:wait_pos)).to eq(0)
    end
    it 'calculates the correct wait time' do
      @fake_results = [@fake_student_request, @fake_student_request2]
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      subject
      expect(assigns(:wait_time)).to eq(0)
    end
  end

  describe 'view index' do
    before(:each) do
      login_slc
      login_tutor
      @fake_student_request = double('StudentQueue', :id => 1, :student_id => 1)
      @fake_student_request2 = double('StudentQueue', :id => 2, :student_id => 2)
      #allow(StudentQueue).to receive(:where).and_return(@fake_student_request)
    end
    it "properly sort" do
      allow(StudentQueue).to receive(:order).with("created_at").and_return(@fake_results)
      expect(assigns(:queue_entries)).to eq(@fake_results)
      get :index
    end
  end

  describe 'when adding a student to the queue it' do
    before :each do
      login_slc
      login_tutor
      @params = {:id => '238745938', :course => 'Ελεννικά'}
      @student_data = {:first_name => 'Athina',
                       :last_name => 'Kaunda',
                       :sid => '238745938',
                       :email => 'student@email.com'}
      @student = FactoryGirl.build(:student, @student_data)
    end
    it 'looks up the student in the database' do
      expect(Student).to receive(:find).with(@params[:id]).and_return(@student)
      post :create, @params
    end
    it 'checks to see if the student is not in line' do
      allow(Student).to receive(:find).with(@params[:id]).and_return(@student)

      post :create, @params
    end
    it 'creates and saves a student_queue entry for the student if they are not aready in queue' do
      allow(Student).to receive(:find).with(@params[:id]).and_return(@student)
      allow(@student).to receive(:student_queue).and_return(nil)
      expect(@student).to receive(:build_student_queue).with(:course => @params[:course])
      expect(@student).to receive(:save)
      post :create, @params
    end
    it 'redirects to the wait time controller' do
      allow(Student).to receive(:find).with(@params[:id]).and_return(@student)
      post :create, @params
      expect(response).to redirect_to wait_time_student_queue_path(@student)
    end

    describe 'if the student does not want to wait' do
      before :each do
        login_slc
        login_tutor
        @id = {:id => @params[:id]}
        @student.build_student_queue
        @student.save
      end
      it 'retrieves the student from the data base' do
        expect(Student).to receive(:find).with(@id[:id]).and_return(@student)
        post :destroy, @id
      end
      it 'writes the student to the drop in histroy' do
        # expect(@student).to receive(:queue_to_history) #how to stub instance method?
        post :destroy, @id
        expect(@student.drop_in_histories).not_to be_empty
      end
      it 'removes the student from the queue' do
        allow(Student).to receive(:find).with(@id[:id]).and_return(@student)
        expect(StudentQueue).to receive(:destroy).with(@student.sid)
        post :destroy, @id
      end
    end
  end
end
