class StudentsController < ApplicationController
  include SecurityRedirectHelper
  before_action :auth_check_app

  def index
    render "students/new"
  end

  def new
  end

  def create
    student_params = {:first_name => params[:student_first_name], :last_name => params[:student_last_name],
                      :sid => params[:student_sid], :email => params[:student_email], :domestic_student => params[:residency],
                      :transfer_student => params[:transfer], :concurrency_student => params[:concurrency], :concurrent_institution => params[:concurrent_institution]}
    @student = Student.get_student(params[:student_sid], student_params)

    if @student.in_line?(params[:meet_type])
      flash[:notice] = 'you are already in line'
      render "students/new"
      return
    end

    if params[:course] == "Other" and params[:course_other]
      params[:course] = params[:course_other]
    end

    course_params = {:course => params[:course], :meet_type => params[:meet_type], :status => "waiting", :emailed => false}
    @student_request = @student.create_student_request(course_params)
    case params[:meet_type]
      when 'scheduled', 'weekly'
        flash[:notice] = 'you are now in line!'
      when 'drop-in'
        redirect_to wait_time_student_request_path(@student_request.id)
        return
      else
        flash[:notice] = 'please select a service type'
    end
    render "students/new"
  end
end
