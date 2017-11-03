class StudentQueuesController < ApplicationController
  def index
    flash[:notice] = nil
	  @drop_in_queue = StudentQueue.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
	  @scheduled_queue = StudentQueue.where(meet_type: "scheduled").where(status: "waiting").order('created_at')
	  @weekly_queue = StudentQueue.where(meet_type: "weekly").where(status: "waiting").order('created_at')
    render "student_queues/index"
  end

  def wait_time
    @sorted_results = StudentQueue.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
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

  def confirm
    flash[:notice] = 'you are now in line!'
    render "students/new"
  end

  def create
    student = Student.find(params[:id]) #after nesting student_queue routes, {:id => :student_id}
    if student.student_queues.empty?
      student.student_queues.build(:course => params[:course], :meet_type => params[:type], :status => "waiting")
      student.save
    else
      flash[:notice] = 'you are already in line'
    end
    redirect_to wait_time_student_queue_path(student.sid)
  end


  def destroy
    @student1 = Student.find(params[:id])
    @student1.student_queues.find(params[:id]).update(:status => "canceled")
    #@student.queue_to_history
    #StudentQueue.destroy(@student.sid)
    # @student.student_queue.destroy
    #send student here if they decide to not to stay in line.
  end
end
