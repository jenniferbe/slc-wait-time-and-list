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
	  @student = Student.find(params[:sid]) 
  end

    

  def confirm
    @student = Student.find(params[:sid])
    @numActiveTutors = 2 #make sure to update this *** with num current active
    #Tutor.where(status => "active").count

    if (@student.get_wait_position <= @numActiveTutors)
      StudentRequest.send_email_next_in_line
    else
      ExampleMailer.confirmation_email(@student).deliver_now
    end

    flash[:notice] = 'you are now in line!'
    render "students/new"
  end

  def destroy
    @student_request = StudentRequest.find(params[:id])
    @student_request.update(:status => "cancelled")
  end

end
