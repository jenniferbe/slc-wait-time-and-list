class ExampleMailer < ApplicationMailer

  	default from: "noreply@slc.com"

		def confirmation_email(student)
			@student = student
			mail(to: @student.email, subject: 'Sample Email')
			# @student.update_attribute(:emailed => true)
		end

		def confirmation_email2(student)
			@student = student
			mail(to: @student.email, subject: '!!!')
			# @student.update_attribute(:emailed => true)
		end

		def check
			mail(to: 'nare429@gmail.com', subject:"checking")
		end

		def next_in_line_email(student)
			@student = student
			mail(to: @student.email, subject: 'you are nex in line')
		end

  	# def next_in_line_email(student)
  	# 	@student = student
   #  	mail(to: @student.email, subject: 'Sample Email')
   #  	@student.update_attribute(:emailed => true)
   #  end

end
