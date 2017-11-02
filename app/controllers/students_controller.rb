class StudentsController < ApplicationController
  include AppSecurityConcern
  def new
    #render new template
  end

  def create
    sid = params[:student_sid]
    if Student.where(:sid => sid).empty?
      @student = Student.create(:first_name => params[:student_first_name],
                               :last_name => params[:student_last_name],
                               :sid => sid,
                               :email => params[:student_email])
    else
      @student = Student.find(sid)
    end

    redirect_to sign_in_student_path(:id => @student.id,
                                     :appointment_type => params[:appointment_type],
                                     :course => params[:student_course])
  end

  def sign_in
    appointment_type = params[:appointment_type]
    id, action = params[:id], 'create'
    case appointment_type
      when 'scheduled'
        redirect_to :controller => 'scheduled_appointments',
                    :action => action,
                    :student_id => id,
                    :course => params[:course]
      when 'weekly'
        redirect_to :controller => 'weekly_appointments',
                    :action => action,
                    :student_id => id,
                    :course => params[:course]
      else #this is for drop_in, we'll have to fix this later to handle when student does specify appointment type.
        redirect_to :controller => 'student_queues',
                    :action => action,
                    :id => id,
                    :course => params[:course]
    end
  end
end