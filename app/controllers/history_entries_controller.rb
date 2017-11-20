class HistoryEntriesController < ApplicationController
  def show

    @test = [:name => "Alex"]
    begin
      @date = params[:history_dates].to_date
    rescue
      @date = ""
    end
    if !(@date == "" or @date == nil)
      @date = @date.to_date
      @history = HistoryEntry.where({created_at: @date..(@date + 1.days)})
      if @history.count > 0
        @found = true
        @drop_in_queue = @history.where({meet_type: "drop-in"})
        @weekly_queue = @history.where({meet_type: "weekly"})
        @scheduled_queue = @history.where({meet_type: "scheduled"})
        @tables = [@drop_in_queue,@scheduled_queue,@weekly_queue]
        @titles = ["Drop In", "Scheduled Appointments", "Weekly Appointments"]
        session[:history] = @history
      else
        @found = false
      end
    end
  end


  def get_report
    @date = params[:id].to_date
    @history = HistoryEntry.where({created_at: @date..(@date + 1.days)}).order('created_at DESC')
    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end