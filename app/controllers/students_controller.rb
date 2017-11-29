class StudentsController < ApplicationController
  include SecurityRedirectHelper
  before_action :auth_check_app

  def index
    render "students/new"
  end

  def new
    #render new template
    flash[:notice] = nil
  end

  def create
    #byebug
    if Student.where(:sid => params[:student_sid]).empty?
      @student = Student.create(:first_name => params[:student_first_name],
                               :last_name => params[:student_last_name],
                               :sid => params[:student_sid],
                               :email => params[:student_email])
    else
      @student = Student.find(params[:student_sid])
    end
    
    unless @student.student_requests.where(meet_type: params[:meet_type], status: "waiting").empty?
      flash[:notice] = 'you are already in line'
      render "students/new"
      return
    end
    
    @student_request = @student.student_requests.build(:course => params[:course], :meet_type => params[:meet_type], :status => "waiting")
    @student.save
    case params[:meet_type]
      when 'scheduled', 'weekly'
        flash[:notice] = 'you are now in line!'
      when 'drop-in'
<<<<<<< HEAD
        redirect_to wait_time_student_request_path(:id => @student.sid, :sid => @student.sid)
=======
        redirect_to wait_time_student_request_path(@student_request.id)
>>>>>>> 6115537efc8dba561011e07351b0b51b5445e110
        return
      else
        flash[:notice] = 'please select a service type'
    end
    render "students/new"
  end

end