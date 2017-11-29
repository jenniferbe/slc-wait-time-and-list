class TutorsController < ApplicationController
  before_action :authenticate_tutor!

  def index
    @drop_in_queue = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @scheduled_queue = StudentRequest.where(meet_type: "scheduled").where(status: "waiting").order('created_at')
    @weekly_queue = StudentRequest.where(meet_type: "weekly").where(status: "waiting").order('created_at')
    @active_sessions = StudentRequest.where(status: "active").order('created_at')
  end

  def activate_session
    student_request = StudentRequest.find(params[:id])
    student_request.update(:status => "active", :tutor_id => current_tutor.id)
    redirect_to tutors_path
  end

  def finish_session
    StudentRequest.find(params[:id]).update(:status => "finished")
    redirect_to tutors_path
  end
end