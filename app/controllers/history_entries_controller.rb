class HistoryEntriesController < ApplicationController
  def show
    begin
      @date = params[:history_dates].to_date.in_time_zone
      @histories = HistoryEntry.get_tables_for_date(@date)
      if @histories.nil?
        @header = "No history entries were found for #{@date.strftime('%A, %B %d, %Y')}"
      else
        @found = true
      end
      @titles = ["Drop In", "Scheduled Appointments", "Weekly Appointments"]
    rescue
      unless params[:history_dates].nil?
        @header = "Please search for a date with the following format: MM-DD-YYYY"
      end
    end
  end


  def get_report
    @date = params[:id].to_date
    @history = HistoryEntry.where({sign_in_time: @date..(@date + 1.days)}).order('sign_in_time DESC')
    respond_to do |format|
      format.html
      format.xlsx
    end
    #respond_to :html, :xlsx
  end
end