require 'rails_helper'
require 'helpers/authentification_helper'
RSpec.describe TutorsController, type: :controller do
  login_tutor
  before :each do
    @drop_in_filter = {:meet_type => 'drop_in', :status => 'waiting'}
    @scheduled_filter = {:meet_type => 'scheduled', :status => 'waiting'}
    @weekly_filter = {:meet_type => 'weekly', :status => 'waiting'}
    @active_filter = {:status => 'active'}
  end
  describe 'index' do
    it 'calls Tutor#filter_student_queue with @drop_in_filter' do
      expect(Tutor).to receive(:filter_student_requests).with(@drop_in_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@scheduled_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@weekly_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@active_filter)

      post :index

    end
    it 'calls Tutor#filter_student_queue with @schedule_filter' do
      allow(Tutor).to receive(:filter_student_requests).with(@drop_in_filter)
      expect(Tutor).to receive(:filter_student_requests).with(@scheduled_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@weekly_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@active_filter)

      post :index

    end
    it 'calls Tutor#filter_student_queue with @weekly_filter' do
      allow(Tutor).to receive(:filter_student_requests).with(@drop_in_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@scheduled_filter)
      expect(Tutor).to receive(:filter_student_requests).with(@weekly_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@active_filter)

      post :index
    end
    it 'calls Tutor#filter_student_queue with @weekly_filter' do
      allow(Tutor).to receive(:filter_student_requests).with(@drop_in_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@scheduled_filter)
      allow(Tutor).to receive(:filter_student_requests).with(@weekly_filter)
      expect(Tutor).to receive(:filter_student_requests).with(@active_filter)

      post :index
    end

  end
end
