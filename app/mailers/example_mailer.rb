class ExampleMailer < ApplicationMailer

  	default from: "noreply@slc.com"

  	def sample_email(student)
    	@student = student
    	mail(to: @student.email, subject: 'Sample Email')
    	# @student.update_attribute(:emailed => true)
  	end

  	# def next_in_line_email(student)
  	# 	@student = student
   #  	mail(to: @student.email, subject: 'Sample Email')
   #  	@student.update_attribute(:emailed => true)
   #  end

end
