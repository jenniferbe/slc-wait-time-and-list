class Tutor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:sid]
  self.primary_key = :sid
  has_many :history_entries
  has_many :student_requests



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
