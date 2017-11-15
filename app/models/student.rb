class Student < ActiveRecord::Base
    self.primary_key = :sid
    has_many :history_entries
    has_many :student_requests
end
