class TutorsController < ApplicationController
  before_action :authenticate_tutor!

  def index
    @active_tutor = current_tutor.active
    @drop_in_queue = Tutor.filter_student_requests({:meet_type => 'drop-in', :status => 'waiting'})
    @scheduled_queue = Tutor.filter_student_requests({:meet_type => 'scheduled', :status => 'waiting'})
    @weekly_queue = Tutor.filter_student_requests({:meet_type => 'weekly', :status => 'waiting'})
    @active_sessions = Tutor.filter_student_requests({:status => 'active'})
  end

  def activate_session
    student_request = StudentRequest.find(params[:id])
    student_request.update(:status => "active", :tutor_id => current_tutor.id, :start_time => Time.zone.now)
    StudentRequest.send_email_next_in_line
    redirect_to tutors_path
  end

  def finish_session
    @finished_student = StudentRequest.find(params[:id])
    @finished_student.update(:status => "finished")
    Tutor.session_to_histories(@finished_student, Time.now, "nothing to say")
    StudentRequest.destroy(params[:id])
    redirect_to tutors_path
  end

  def check_in
    current_tutor.active = true
    current_tutor.save
    redirect_to tutors_path
  end

  def check_out
    current_tutor.active = false
    current_tutor.save
    redirect_to tutors_path
  end
end