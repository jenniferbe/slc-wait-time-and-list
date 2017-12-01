require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /the list of students with email/ do |student_data_table|
  student_data_table.hashes.each do |data|
    # delete the create time if it exists, since we want this to go in the queue.
    create_time = data[:created_at]
    data.delete('created_at')
    student_data = { :first_name => data[:first_name], :last_name => data[:last_name], :sid => data[:sid], :email => data[:email] }
    queue_data = { :meet_type => data[:meet_type], :status => data[:status] }
    student = Student.create(student_data)

    if create_time
      queue_data[:created_at] = create_time
      student.student_requests.build(queue_data)
    else
      student.student_requests.build()
    end
    student.save
  end
end

Given(/^There are (\d+) tutors$/) do |arg|
  @numTutor = arg
end



Then(/^my waiting position should be (\d+)$/) do |arg|
  @waiting = StudentRequest.where(:status => 'waiting').count
  expect(@waiting).to eql arg

end

And(/^Tutor picked up "([^"]*)"$/) do |studentname|
  @ssid = (Student.find_by(first_name: studentname)).sid
  StudentRequest.where(student_id: @ssid).update_all(status: 'in-progress')
  #tudentRequest.where(:student_id => @S.sid).update(:status, 'in-progress')
end