class ExampleMailer < ApplicationMailer

  	default from: "noreply@slc.com"

  	def sample_email(student)
    	@student = student
    	mail(to: @student.email, subject: 'Sample Email')
  	end

<<<<<<< HEAD
  	def next_in_line_email(student)
  		@student = student
    	mail(to: @student.email, subject: 'Sample Email')
    end

=======
>>>>>>> e456c5346208ad8a7b6fd6b8b4425f93a442d72b
end
