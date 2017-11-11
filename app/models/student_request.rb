class StudentRequest < ActiveRecord::Base
  self.primary_key = :student_id
  belongs_to :student
end
