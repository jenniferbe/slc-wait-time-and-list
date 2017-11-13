class ExampleMailer < ApplicationMailer

  	default from: "noreply@slc.com"

  	def sample_email(student)
    	@student = student
    	mail(to: @student.email, subject: 'Sample Email')
  	end

end
