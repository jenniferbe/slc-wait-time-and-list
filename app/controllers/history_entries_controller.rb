class HistoryEntriesController < ApplicationController
  def show
    @date = params[:date]
    unless @date.nil?
      HistoryEntry.where({created_at: @date..(@date + 1.days)})
    end
  end
end