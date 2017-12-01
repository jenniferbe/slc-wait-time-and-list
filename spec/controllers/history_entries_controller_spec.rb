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
        expect(HistoryEntry).to_not receive(:get_tables_for_date)
        get :show, history_dates: ""
      end
    end
    describe 'when the date exists' do
      it 'searches dates if it is valid' do
        expect(HistoryEntry).to receive(:get_tables_for_date)
        get :show, history_dates: "01/01/2017"
      end
    end
  end
  describe 'get_report' do
    it 'renders an xlsx file' do
      date = "01/01/2017".in_time_zone.to_date
      HistoryEntry.create(:student_id => "1234", :course => "English R1A", :sign_in_time => date)
      get :get_report, id: "01/01/2017", format: :xlsx
    end
  end
end