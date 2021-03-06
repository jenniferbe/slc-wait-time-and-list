class TutorsController < ApplicationController
  before_action :authenticate_tutor!

  def index
    @tutor = current_tutor
    @drop_in_queue = Tutor.filter_student_requests({:meet_type => 'drop-in', :status => 'waiting'})
    @scheduled_queue = Tutor.filter_student_requests({:meet_type => 'scheduled', :status => 'waiting'})
    @weekly_queue = Tutor.filter_student_requests({:meet_type => 'weekly', :status => 'waiting'})
    @active_sessions = Tutor.filter_student_requests({:status => 'active'})
    @time = Time.now.in_time_zone
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
    Tutor.session_to_histories(@finished_student, Time.now.in_time_zone, "N/A")
    StudentRequest.destroy(params[:id])
    redirect_to tutors_path
  end

  def check_in
    expected_leave_time = DateTime.now.in_time_zone.change(hour: params[:date][:hour], min: params[:date][:minute], sec: 0)
    current_tutor.update(expected_leave_time: expected_leave_time, active: true)
    redirect_to tutors_path
  end

  def check_out
    current_tutor.update(expected_leave_time: nil, active: false)
    redirect_to tutors_path
  end
end