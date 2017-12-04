class StudentRequestsController < ApplicationController
  include SecurityRedirectHelper
  before_action :auth_check_app

  def wait_time
    @wait_time = StudentRequest.calculate_wait_time
    if @wait_time
      @wait_time = @wait_time.strftime("%l:%M%P")
    else
      @student_request = StudentRequest.find(params[:id])
      # @student_request = StudentRequest.where(:student_id => params[:id])[0]
      @student_request.update(:status => "cancelled")
    end
	  #will need the student's id in when confirming, so we pass it around

	  @student_request = StudentRequest.find(params[:id])
  end

  def confirm
    student_request = StudentRequest.find(params[:id]).update(:status =>"waiting")
    @student = StudentRequest.find(params[:id]).student

    @numActiveTutors = Tutor.where(:active => true).count
    if (@student.get_wait_position <= @numActiveTutors)
      StudentRequest.send_email_next_in_line
    else
      ExampleMailer.confirmation_email(@student).deliver_now
    end

    flash[:notice] = 'You are now in line!'
    redirect_to students_path
  end

  def destroy
    @student_request = StudentRequest.find(params[:id])
    # @student_request = StudentRequest.where(:student_id => params[:id])[0]
    # @student_request.update(:status => "cancelled")
    flash[:notice] = 'You are not in line!'
    Tutor.session_to_histories(@student_request, nil, "")
    StudentRequest.destroy(params[:id])
    redirect_to students_path
  end

end
