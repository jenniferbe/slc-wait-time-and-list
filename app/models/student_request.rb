class StudentRequest < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :student

  def self.get_active_queues
    waiting = StudentRequest.where(status: "waiting").order('created_at')
  	[waiting.where(meet_type: "drop-in"), waiting.where(meet_type: "scheduled"), waiting.where(meet_type: "weekly"),
  	  StudentRequest.where(status: "active").order('created_at')]
  end

  def self.send_email_next_in_line
    #send an email to next person who hasn't been emailed yet
    @next_student_in_line = StudentRequest.where(:emailed => false)[0]

    unless @next_student_in_line == nil
      @studentid = @next_student_in_line.student_id
      @student = Student.find(@studentid)
      ExampleMailer.next_in_line_email(@student).deliver_now
      StudentRequest.where(:student_id => @studentid)[0].update(:emailed => true)
    end

  end

end
