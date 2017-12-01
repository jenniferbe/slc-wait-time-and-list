class StudentRequestsController < ApplicationController
  include SecurityRedirectHelper
  before_action :auth_check_app


  def index
	  @drop_in_queue, @scheduled_queue, @weekly_queue, @active_sessions = StudentRequest.get_active_queues
  end

  def wait_time
    @sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @wait_pos = 0
    @sorted_results.each do |entry|
      break if "#{entry.id}" == params[:id]
      @wait_pos += 1
    end
	  @wait_time = @wait_pos * 30
	  
	  #will need the student's id in when confirming, so we pass it around

	  @student_request = StudentRequest.find(params[:id]);
  end


  def send_email_next_in_line
    #send an email to next person who hasn't been emailed yet
   
    @next_student_in_line = StudentRequest.where(:emailed => false)[0] 
    @studentid = @next_student_in_line.student_id
    @student = Student.find(@studentid)
    ExampleMailer.next_in_line_email(@student).deliver_now
    StudentRequest.where(:student_id => @studentid)[0].update(:emailed => true)

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

    

  def confirm

    @student = StudentRequest.find(params[:id]).student

    @numActiveTutors = 2 #make sure to update this *** with num current active
    #Tutor.where(status => "active").count

    if (@student.get_wait_position <= @numActiveTutors)
      StudentRequest.send_email_next_in_line
    else
      ExampleMailer.confirmation_email(@student).deliver_now
    end

    flash[:notice] = 'you are now in line!'
    redirect_to students_path
  end

  def destroy
    @student_request = StudentRequest.find(params[:id])
    @student_request.update(:status => "cancelled")
    flash[:notice] = 'you are not in line!'
    redirect_to students_path
  end

end
