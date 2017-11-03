class Tutor < ActiveRecord::Base
  self.primary_key = :sid
  has_many :drop_in_histories
  has_many :studen_queues


  #moves a student from the queue to the active session.
  def queue_to_session(student_queue)
    if student_queue.instance_of? StudentQueue
      session_data = remove_unwanted(student_queue)
      time_now = Time.now.in_time_zone('Pacific Time (US & Canada)')
      session_data[:start_time] = time_now
      session_data[:wait_time] = (session_data[:start_time] - time_now) / 60
      self.create_active_session(session_data)
    else
      throw ArgumentError(%Q{expected student_queue but got "#{student_queue}"})
    end
  end

  private
    def remove_unwanted(student_queue)
      queue_data = student_queue.attributes
      remove = %w(created-at, updated_at)
      remove.each do |value|
        queue_data.delete(value.to_sym)
      end
      queue_data
    end
end
