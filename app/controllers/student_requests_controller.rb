class StudentRequestsController < ApplicationController
  include SecurityRedirectHelper
  before_action :auth_check_app


  def index
    flash[:notice] = nil
	  @drop_in_queue = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
	  @scheduled_queue = StudentRequest.where(meet_type: "scheduled").where(status: "waiting").order('created_at')
	  @weekly_queue = StudentRequest.where(meet_type: "weekly").where(status: "waiting").order('created_at')
	  @active_sessions = StudentRequest.where(status: "active").order('created_at')
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
	  @student = Student.find(params[:sid]) 
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
    
  def new
    # render new template	
	  @student = Student.where(:sid => params[:id])

  end

  def confirm
    @student = Student.find(params[:sid])

    @numActiveTutors = 2 #make sure to update this *** with num current active
    #Tutor.where(status => "active").count

    if (@student.get_wait_position <= @numActiveTutors)
      send_email_next_in_line
    else
      ExampleMailer.confirmation_email(@student).deliver_now
    end


    #
    # if (@student.get_wait_time <= 30)
    #   send_email_next_in_line(@student)
    # else
    #   ExampleMailer.sample_email(@student).deliver_now
    # end

    # if StudentRequests.find(params[:emailed])

    flash[:notice] = 'you are now in line!'
    render "students/new"
  end

  def destroy
    @student_request = StudentRequest.find(params[:id])
    @student_request.update(:status => "cancelled")
  end

end
