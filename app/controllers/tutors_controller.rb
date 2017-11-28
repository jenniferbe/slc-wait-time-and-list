class TutorsController < ApplicationController
  before_action :authenticate_tutor!

  def index
    flash[:notice] = nil
    @drop_in_queue = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @scheduled_queue = StudentRequest.where(meet_type: "scheduled").where(status: "waiting").order('created_at')
    @weekly_queue = StudentRequest.where(meet_type: "weekly").where(status: "waiting").order('created_at')
    @active_sessions = StudentRequest.where(status: "active").order('created_at')
  end
end
