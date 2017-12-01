class StudentRequest < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :student

  def self.get_active_queues
    waiting = StudentRequest.where(status: "waiting").order('created_at')
  	[waiting.where(meet_type: "drop-in"), waiting.where(meet_type: "scheduled"), waiting.where(meet_type: "weekly"),
  	  StudentRequest.where(status: "active").order('created_at')]
  end

  def get_wait_time
    @sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @wait_pos = 0
    @sorted_results.each do |entry|
      break if "#{entry.student_id}" == self.id
      @wait_pos += 1
    end
    @wait_time = @wait_pos * 30
  end

  def get_wait_position
    @sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @wait_pos = 0
    @sorted_results.each do |entry|
      break if "#{entry.student_id}" == self.id
      @wait_pos += 1
    end
    @wait_pos
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
