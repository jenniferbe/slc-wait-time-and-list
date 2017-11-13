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
    
  def new
    # render new template	
  end

  def confirm
    @student = Student.find(params[:sid]) 
    ExampleMailer.sample_email(@student).deliver
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
    redirect_to student_requests_path
  end
  
  def finish_session
    StudentRequest.find(params[:id]).update(:status => "finished")
    redirect_to student_requests_path
  end
end
