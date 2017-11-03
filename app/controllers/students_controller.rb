class StudentsController < ApplicationController
  def index
    render "students/new"
  end

  def new
    #render new template
    flash[:notice] = nil
  end

  def create
    if params[:meet_type].nil?
      flash[:notice] = 'Please select a service type'
      render "students/new"
      return
    end
    if params[:course] == "0"
      flash[:notice] = 'Please select a course'
      render "students/new"
      return
    end

    sid = params[:student_sid]
    if Student.where(:sid => sid).empty?
      @student = Student.create(:first_name => params[:student_first_name],
                               :last_name => params[:student_last_name],
                               :sid => sid,
                               :email => params[:student_email])
    else
      @student = Student.find(sid)
    end
    if @student.student_queues.empty?
      @student.student_queues.build(:course => params[:course], :meet_type => params[:meet_type], :status => "waiting")
      @student.save
    else
      flash[:notice] = 'you are already in line'
      render "students/new"
      return
    end
    case params[:meet_type]
      when 'scheduled'
        flash[:notice] = 'you are now in line!'
        render "students/new"
      when 'weekly'
        flash[:notice] = 'you are now in line!'
        render "students/new"
      when 'drop-in'
        redirect_to wait_time_student_queue_path(@student.sid)
      else
        flash[:notice] = 'please select a service type'
        render "students/new"
    end
  end
end