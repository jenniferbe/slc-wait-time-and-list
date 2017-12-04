require 'rails_helper'

RSpec.describe StudentRequest, type: :model do
  describe "get_active_queues" do
    it "returns active queues" do
      expect(StudentRequest.get_active_queues.count).to eq(4)
    end
  end
  describe "send_email_next_in_line" do
    it "emails the person next in line" do
      Student.create(:sid => 1)
      fake_student_request = StudentRequest.create(:id => 1, :student_id => 1)
      expect(StudentRequest).to receive(:where).and_return([fake_student_request]).twice
      expect_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_now)
      StudentRequest.send_email_next_in_line
    end
  end
end
