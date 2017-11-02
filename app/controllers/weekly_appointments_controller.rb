class WeeklyAppointmentsController < ApplicationController
  include AppSecurityConcern
  def create
    student = Student.find(params[:student_id])
    if student.weekly_appointment.nil?
      student.build_weekly_appointment(:course => params[:course])
      student.save
    else
      flash[:notice] = 'you have already signed up, please wait and a tutor will be with you shortly'
    end
  end
end