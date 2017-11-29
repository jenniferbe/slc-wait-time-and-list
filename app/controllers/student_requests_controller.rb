class StudentRequestsController < ApplicationController
  include SecurityRedirectHelper
  before_action :auth_check_tutor


  def index
    flash[:notice] = nil
	  @drop_in_queue = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
	  @scheduled_queue = StudentRequest.where(meet_type: "scheduled").where(status: "waiting").order('created_at')
	  @weekly_queue = StudentRequest.where(meet_type: "weekly").where(status: "waiting").order('created_at')
	  @active_sessions = StudentRequest.where(status: "active").order('created_at')
    render "student_requests/index"
  end

  def wait_time
    @sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @wait_pos = 0
    @sorted_results.each do |entry|
      break if "#{entry.student_id}" == params[:id]
      @wait_pos += 1
    end

	  @wait_time = @wait_pos * 30
	  
	  #will need the student's id in when confirming, so we pass it around
	  @student = Student.find(params[:sid]) 
  end


  def send_email_next_in_line
    #send an email to next person who hasn't been emailed yet, when

    #@student = StudentRequest.where(:emailed => false)[0]
    #ExampleMailer.next_in_line_email(@student).deliver_now




    #Doesnt have data for the number of tutors working.
    @numTutor = 2

    #the wait_time is less than 30 min == you will be the nth position in wait list s.t. n == number of tutors.


    @numStudents = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").count

    if @numStudents >= @numTutor

      @studentList = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
      @studentid = 0

      @studentList.each do |entry|
        if entry.get_wait_position == @numTutor
          @studentid = entry.student_id
          break
        end
      end

      @student = Student.find(@studentid)
      ExampleMailer.next_in_line_email(@student).deliver_now

    end




  end
    
  def new
    # render new template	
  end

  def confirm
    @student = Student.find(params[:sid])
    @numTutor = 2

    if (@student.get_wait_position <= @numTutor)
      ExampleMailer.confirmation_email(@student).deliver_now
    else
      ExampleMailer.confirmation_email2(@student).deliver_now
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

  def create
    student = Student.find(params[:id]) #after nesting student_queue routes, {:id => :student_id}
    if student.student_requests.empty?
      student.student_requests.build(:course => params[:course], :meet_type => params[:type], :status => "waiting")
      student.save
    else
      flash[:notice] = 'you are already in line'
    end
    redirect_to wait_time_student_request_path(student.sid)
  end


  def destroy
    @student1 = Student.find(params[:id])
    @student1.student_requests.find(params[:id]).update(:status => "cancelled")
    #@student.queue_to_history
    #StudentRequest.destroy(@student.sid)
    # @student.student_queue.destroy
    #send student here if they decide to not to stay in line.
  end
  
  def activate_session
    StudentRequest.find(params[:id]).update(:status => "active")
    send_email_next_in_line

    redirect_to student_requests_path
  end
  
  def finish_session
    StudentRequest.find(params[:id]).update(:status => "finished")
    redirect_to student_requests_path
  end
end
