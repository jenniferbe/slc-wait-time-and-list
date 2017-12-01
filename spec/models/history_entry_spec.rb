require 'rails_helper'

RSpec.describe HistoryEntry, type: :model do
  date = "01/01/2017".to_date.in_time_zone
  describe "#get_tables_for_date" do
    it 'returns nil if no entries exist' do
      tables = HistoryEntry.get_tables_for_date(date)
      expect(tables).to eq(nil)
    end
    it 'returns tables if entries exist' do
      HistoryEntry.create(:student_id => "1234", :course => "English R1A", :sign_in_time => "01/01/2017".to_date.in_time_zone)
      tables = HistoryEntry.get_tables_for_date(date)
      history = HistoryEntry.where({sign_in_time: date...(date + 1.days)})
      drop_in_queue = history.where({meet_type: "drop-in"})
      weekly_queue = history.where({meet_type: "weekly"})
      scheduled_queue = history.where({meet_type: "scheduled"})
      expect(tables).to eq([drop_in_queue, weekly_queue, scheduled_queue])
    end
  end
end
