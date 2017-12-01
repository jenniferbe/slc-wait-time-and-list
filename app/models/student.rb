class Student < ActiveRecord::Base

  self.primary_key = :sid
  has_many :history_entries
  has_many :student_requests
  
  
  def self.get_student(sid, create_params)
    student = Student.where(:sid => sid).first
    student ||= Student.create(create_params)
    student
  end
  
  def in_line?(meet_type)
    not self.student_requests.where(meet_type: meet_type, status: "waiting").empty?
  end
  
  def create_student_request(create_params)
    student_request = self.student_requests.build( create_params)
    self.save
    return student_request
  end
  
  #create_student request...getwaittime and get wait position can also be in student_request

  def get_wait_position
    @sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
    @wait_pos = 0
    @sorted_results.each do |entry|
      break if "#{entry.student_id}" == self.id
      @wait_pos += 1
    end
    @wait_pos
  end

end
