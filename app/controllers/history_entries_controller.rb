class HistoryEntriesController < ApplicationController
  def show
    @date = params[:history_dates]
    if !(@date == nil or @date == "")
      @date = @date.to_date
      @history = HistoryEntry.where({created_at: @date..(@date + 1.days)})
      if @history.count > 0
        @found = true
        @drop_in_queue = @history.where({meet_type: "drop-in"})
        @weekly_queue = @history.where({meet_type: "weekly"})
        @scheduled_queue = @history.where({meet_type: "scheduled"})
      else
        @found = false
      end
    end
  end
end