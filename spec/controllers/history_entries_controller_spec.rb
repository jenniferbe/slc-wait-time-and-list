require 'rails_helper'

RSpec.describe HistoryEntriesController, type: :controller do
  describe 'show' do
    describe 'when there is no search' do
      it 'does not display help text' do
        expect(@header).to eq(nil)
        get :show
      end
    end
    describe 'when the date is invaild' do
      it 'does not search date' do
        expect(HistoryEntry).to_not receive(:get_tables_for_date).and_call_original
        get :show, history_dates: ""
      end
    end
    describe 'when the date exists' do
      it 'searches dates and returns entries if it is valid' do
        date = "01/01/2017".to_date.in_time_zone
        entry = HistoryEntry.create(:student_id => "1234", :course => "English R1A", :sign_in_time => date)
        entry.save
        expect(HistoryEntry).to receive(:get_tables_for_date).with(date).and_call_original
        get :show, history_dates: "01/01/2017"
      end
      it 'returns a message if date has no entries' do
        date = "01/01/2017".to_date.in_time_zone
        expect(HistoryEntry).to receive(:get_tables_for_date).with(date).and_call_original
        get :show, history_dates: "01/01/2017"
      end
    end
  end
  describe 'get_report' do
    it 'renders an xlsx file' do
      date = "01/01/2017".to_date.in_time_zone
      entry = HistoryEntry.create(:student_id => "1234", :course => "English R1A", :sign_in_time => date)
      get :get_report, id: "01/01/2017", format: :xlsx
    end
  end
end