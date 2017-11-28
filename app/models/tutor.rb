class Tutor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:sid]
  self.primary_key = :sid
  has_many :drop_in_histories
  has_many :student_requests


  #moves a student from the queue to the active session.
  def queue_to_session(student_request)
    
  end
end
