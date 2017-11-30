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
    send_email_next_in_line
    redirect_to tutors_path
  end

  def finish_session
    StudentRequest.find(params[:id]).update(:status => "finished")
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
    # if @numStudentsWaiting >= @numActiveTutors

    # @studentList = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')

    # @int = 1

    # @studentList.each do |entry|
    #   if @int > @numTutor
    #     break
    #   end
    #   if !entry.emailed
    #     @studentid = entry.student_id
    #     @student = Student.find(@studentid)
    #     ExampleMailer.next_in_line_email(@student).deliver_now
    #     StudentRequest.find(@studentid).update(:emailed => true)

    #   end
    #   @int += 1

    # end

  end
end