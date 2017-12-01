class TutorsController < ApplicationController
  before_action :authenticate_tutor!

  def index
    @drop_in_queue = Tutor.filter_student_requests({:meet_type => 'drop_in', :status => 'waiting'})
    @scheduled_queue = Tutor.filter_student_requests({:meet_type => 'scheduled', :status => 'waiting'})
    @weekly_queue = Tutor.filter_student_requests({:meet_type => 'weekly', :status => 'waiting'})
    @active_sessions = Tutor.filter_student_requests({:status => 'active'})
  end

  def activate_session
    student_request = StudentRequest.find(params[:id])
    student_request.update(:status => "active", :tutor_id => current_tutor.id, :start_time => Time.zone.now)
    send_email_next_in_line
    redirect_to tutors_path
  end

  def finish_session
    @finished_student = StudentRequest.find(params[:id])
    @finished_student.update(:status => "finished")
    Tutor.session_to_histories(@finished_student, Time.now, "nothing to say")
    StudentRequest.destroy(params[:id])
    redirect_to tutors_path
  end

  def send_email_next_in_line
    #send an email to next person who hasn't been emailed yet
    @next_student_in_line = StudentRequest.where(:emailed => false)[0]
    unless @next_student_in_line == nil
      @studentid = @next_student_in_line.student_id
      @student = Student.find(@studentid)
      ExampleMailer.next_in_line_email(@student).deliver_now
      StudentRequest.where(:student_id => @studentid)[0].update(:emailed => true)
    end
  end
end