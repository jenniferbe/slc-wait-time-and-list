class Student < ActiveRecord::Base
    self.primary_key = :sid
    has_many :drop_in_histories
    has_many :student_queues


  def destroy_student_queue
    if self.student_queue
      self.student_queue.destroy
      self.student_queue= nil
      self.save
    end
  end

  def queue_to_history
    if self.student_queue
      self.drop_in_histories.build(:course => self.student_queue.course,
                                   :status => 'canceled')
      self.save
    end
  end
end
