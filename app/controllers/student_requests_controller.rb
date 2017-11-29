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
	  @student = Student.where(:sid => params[:id])
  end

  def confirm
    flash[:notice] = 'you are now in line!'
    render "students/new"
  end

  def destroy
    @student_request = StudentRequest.find(params[:id])
    @student_request.update(:status => "cancelled")
  end
  
  def activate_session
    StudentRequest.find(params[:id]).update(:status => "active", :start_time => Time.now)

    # lost support for calculating the time a student waited to be helped
    # tempstudent.update(:status => "active", :wait_time => time_diff(tempstudent.created_at, Time.now))
    redirect_to student_requests_path
  end
  
  def finish_session
    @finished_student = StudentRequest.find(params[:id])
    @finished_student.update(:status => "finished")
    Tutor.session_to_histories(@finished_student, Time.now, "nothing to say")
    StudentRequest.destroy(params[:id])
    redirect_to student_requests_path
  end
end
