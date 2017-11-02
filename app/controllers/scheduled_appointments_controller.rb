class ScheduledAppointmentsController < ApplicationController
  include AppSecurityConcern
  def create
    student = Student.find(params[:student_id])
    if student.scheduled_appointment.nil?
      student.build_scheduled_appointment(:course => params[:course])
      student.save
    else
      flash[:notice] = 'you have already checked in, please wait and a tutor will be with you shortly'
    end
  end
end