class StudentQueuesController < ApplicationController
  include TutorSecurityConcern
  def index
	  @queue_entries = StudentQueue.order('created_at')
    render "student_queues/index"
  end

  def wait_time
    @sorted_results = StudentQueue.order('created_at')
    @wait_pos = 0
    @sorted_results.each do |entry|
      break if "#{entry.student_id}" == params[:id]
      @wait_pos += 1
    end

	  @wait_time = @wait_pos * 30
	  
	  #will need the student's id in when confirming, so we pass it around
	  @student = Student.where(:sid => params[:id]) 
  end
    
  def new
    # render new template	
  end

  def create
    student = Student.find(params[:id]) #after nesting student_queue routes, {:id => :student_id}
    if student.student_queue.nil?
      student.build_student_queue(:course => params[:course])
      student.save
    else
      flash[:notice] = 'you are already in line'
    end
    redirect_to wait_time_student_queue_path(student.sid)
  end

  def confirm
    #wait in line
  end

  def destroy
    @student = Student.find(params[:id])
    @student.queue_to_history
    StudentQueue.destroy(@student.sid)
    # @student.student_queue.destroy
    #send student here if they decide to not to stay in line.
  end
end
