require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe 'filter_student_requests' do

    it 'queries the student request model with the filter arguments' do
      fake_student_request = double('StudentQueue', :id => 1, :student_id => 1)
      fake_proxy = double(:order => fake_student_request)
      filter_values = {:first_name => 'Hello', :status => 'greeting', :sid => '23456'}
      expect(StudentRequest).to receive(:where).with(filter_values).and_return(fake_proxy);
      expect(fake_proxy).to receive(:order).with('created_at').and_return(fake_student_request);

      # expect(Tutor).to receive(:order).with('created_at')
      Tutor.filter_student_requests(filter_values)
    end
  end
end
