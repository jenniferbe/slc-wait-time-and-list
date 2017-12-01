class HistoryEntriesController < ApplicationController
  def show
    begin
      @date = params[:history_dates].to_date.in_time_zone
    rescue
      @date = ""
    end
    if !(@date == "" or @date == nil)
      @histories = HistoryEntry.get_tables_for_date(@date)
      @found = not @histories.nil?
      @titles = ["Drop In", "Scheduled Appointments", "Weekly Appointments"]
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
  end
end