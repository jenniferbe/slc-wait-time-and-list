class HistoryEntriesController < ApplicationController
  before_action :authenticate_tutor!
  def show
    @date = params[:history_dates]
    if params[:history_dates].nil?
      @found, @histories, @header = nil, nil, nil
    else
      @date, @found, @histories, @header = HistoryEntry.get_histories_info(@date)
    end
    @titles = ["Drop In", "Scheduled Appointments", "Weekly Appointments"]
  end


  def get_report
    @date = params[:id].to_date
    @history = HistoryEntry.where({sign_in_time: @date..(@date + 1.days)}).order('sign_in_time DESC')
    # respond_to do |format|
    #   format.html
    #   format.xlsx
    # end
    respond_to :html, :xlsx
  end
end