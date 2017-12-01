require 'rails_helper'

RSpec.describe StudentRequestsHelper, type: :helper do
  describe "time diff" do
    it "calculates the time difference between two times" do
      time = Time.now
      calculation = time_diff(time, time + 1.hour)
      expect(calculation).to eq("01h:00m")
    end
  end
end
