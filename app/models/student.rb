class Student < ActiveRecord::Base
    self.primary_key = :sid
    has_many :drop_in_histories
    has_many :student_queues
end
