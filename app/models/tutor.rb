class Tutor < ActiveRecord::Base
  self.primary_key = :sid
  has_many :drop_in_histories
  has_many :student_requests


  #moves a student from the queue to the active session.
  def queue_to_session(student_request)
    
  end
end
