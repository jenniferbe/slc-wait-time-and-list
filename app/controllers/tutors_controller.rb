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
    student_request.update(:status => "active", :tutor_id => current_tutor.id, :start_time => Time.zone.now)
    redirect_to tutors_path
  end

  def finish_session
    @finished_student = StudentRequest.find(params[:id])
    @finished_student.update(:status => "finished")
    Tutor.session_to_histories(@finished_student, Time.now, "nothing to say")
    StudentRequest.destroy(params[:id])
    redirect_to tutors_path
  end
end