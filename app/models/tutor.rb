class Tutor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:sid]
  self.primary_key = :sid
  has_many :history_entries
  has_many :student_requests

  #would be a less intrusive query if there was an active session table
  def is_tutoring?
    self.student_requests.where(status: "active").exists?
  end

  #usable if tutor is tutoring
  def get_time_tutor_can_help
    start_time = self.student_requests.where(status:"active").first.start_time
    if(Time.now-start_time)/60>30 #if a tutor has been working longer than 30 min
      return Time.now + 60*30
    end
    return start_time + 60*30
  end
  #moves a student from the queue to the active session.
  def queue_to_session(student_request)
    
  end

  def self.filter_student_requests filter_values
    return StudentRequest.where(filter_values).order('created_at')
  end


  def self.session_to_histories(student_request, end_time, tutor_notes)
    HistoryEntry.create(:student_id => student_request.student_id, :course => student_request.course,
                          :tutor_sid => student_request.tutor_id,:start_time => student_request[:start_time],
                          :end_time => end_time, :tutor_notes => tutor_notes, :sign_in_time => student_request[:created_at],
                          :status => student_request.status, :meet_type =>student_request.meet_type)
  end
end
