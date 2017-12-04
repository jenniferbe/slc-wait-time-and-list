#studentRequest can act as a proxy between student and tutor
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

  def self.tutor_has_time_to_help?(time_to_leave,time_to_help)
    if(time_to_leave-time_to_help)/60 > 20
      return true
    end
    return false
  end

  def self.generate_help_queue
    help_queue, active_tutors = Array.new(), Tutor.where(active: true)
    time = Time.now.in_time_zone
    active_tutors.each do |tutor|
      start_time = tutor.is_tutoring? ? tutor.get_time_tutor_can_help : time
      help_queue.push({start_time: start_time, sid: tutor.sid, elt: tutor.expected_leave_time})
    end
    help_queue
  end

  def self.calculate_wait_time
    #create an array that stores when a tutor will leave and when is their next availabiltiy
    help_queue = StudentRequest.generate_help_queue
    return nil if help_queue.length == 0

    help_queue = help_queue.sort_by {|tutor| tutor[:start_time]}
    num_in_line = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").count #+1 because that represents the new student
    #but since we atm put the new student in line before confirming there is no +1

    #calculate waitimes for student X in line...these items could be saved and cached but it wont be accurate
    #to do so until we know the full schedule of tutors that day(=>tutorworkday) as the system doesn't know when new tutors will come in
    for i in 0...num_in_line
      j = i%help_queue.length
      helped = false
      while(helped == false)
        tutor_time = help_queue[j]
        if StudentRequest.tutor_has_time_to_help?(tutor_time["elt".to_sym].to_time,tutor_time["start_time".to_sym])
          help_queue[j]["start_time".to_sym] = tutor_time["start_time".to_sym] + 30 * 60
          helped = true
        else
          help_queue.delete_at(j)
          if help_queue.length == 0
            return nil
          end
          j = j%help_queue.length #will set index to next tutor in help_queue
        end
      end
    end
    return help_queue[j]["start_time".to_sym] - 30*60
  end
end

