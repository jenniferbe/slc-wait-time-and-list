class Student < ActiveRecord::Base
<<<<<<< HEAD
    self.primary_key = :sid
    has_many :drop_in_histories
    has_many :student_requests


    def get_wait_time
	    @sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
	    @wait_pos = 0
	    @sorted_results.each do |entry|
	      break if "#{entry.student_id}" == self.id
	      @wait_pos += 1
	    end
	  @wait_time = @wait_pos * 30
		end

		def get_wait_position
			@sorted_results = StudentRequest.where(meet_type: "drop-in").where(status: "waiting").order('created_at')
			@wait_pos = 0
			@sorted_results.each do |entry|
				break if "#{entry.student_id}" == self.id
				@wait_pos += 1
			end
			@wait_pos
		end
=======
 self.primary_key = :sid
has_many :history_entries
has_many :student_requests
>>>>>>> origin/demo
end
