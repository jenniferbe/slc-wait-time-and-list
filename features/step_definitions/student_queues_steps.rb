def get_student(first_name, last_name)
  student_proxy = Student.where(:first_name => first_name, :last_name => last_name)
  if student_proxy.empty? ; return nil ; end
  student_proxy[0]
end

Given /^"(.*)" "(.*)" is on the wait time page$/ do |first_name, last_name|
  sid = 123456
  steps %Q{
    Given I am on the home page
    Then I fill in "student_first_name" with "#{first_name}"
    And I fill in "student_last_name" with "#{last_name}"
    And I fill in "student_sid" with "#{sid}"
    And I click on "form_submit"
    Then I should be on the wait time page for "#{first_name}" "#{last_name}"
  }
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

Given /^"(.*)" "(.*)" is already in line$/ do |first_name, last_name|
  steps %Q{
    Given "#{first_name}" "#{last_name}" is on the wait time page
    And she clicks on "YES"
    Given "#{first_name}" "#{last_name}" is on the wait time page
  }
end

Then /^"(.*)" "(.*)" should( not)? be in line$/ do |first_name, last_name, not_be_in_line|

  student_list = Student.where(:first_name => first_name, :last_name => last_name)
  student_list.should_not be_empty
  student = student_list[0]
  if not_be_in_line
    expect(student.student_requests.find(student.sid).status).to eq("cancelled")
  else
    expect(student.student_requests.find(student.sid).status).to eq("waiting")
  end
end

And /^(?:she|he?) clicks on "(.*)"$/ do |button|
  steps %Q{ When follow "#{button}"}
end

Given /^I specify "(.*)"$/ do |string|
  pending
end

Given /^"(.*)" "(.*)" is signed up for all three appointments$/ do |first_name, last_name|
  sid = 25804240
  steps %Q{
  Given the following student queues exist:
  | first_name      | last_name     | sid      | meet_type  | status  | created_at              |
  | #{first_name}   | #{last_name}  | #{sid}   | drop-in    | waiting | 2012-09-10 14:44:24 UTC |

  }
  student = Student.find(sid)
  student.student_requests.build(:meet_type => 'scheduled', :status => 'waiting')
  student.student_requests.build(:meet_type => 'weekly', :status => 'waiting')
  student.save

end

When /^"(.*)" "(.*)" signs up for any of the three appointments again$/ do |first_name, last_name|

  student_proxy = Student.where(:first_name => first_name, :last_name => last_name)
  if !student_proxy.empty?
    sid = student_proxy[0].sid
    steps %Q{
      Given I am on the home page
      Given "#{first_name}" "#{last_name}" with id "#{sid}" signs up for "weekly"
      Given "#{first_name}" "#{last_name}" with id "#{sid}" signs up for "drop-in"
      Given "#{first_name}" "#{last_name}" with id "#{sid}" signs up for "scheduled"
    }
  end
end

When /^"(.*)" "(.*)" is a student with sid "(.*)"$/ do |first_name, last_name, sid|
  Student.create!(:sid => sid, :first_name => first_name, :last_name => last_name)
end


When /^"(.*)" "(.*)" tries to sign up for "(.*)"$/ do |first_name, last_name, appointment_types|
  appointments = appointment_types.split(', ')
  student = get_student(first_name, last_name)
  student.should_not be_nil
  appointments.each do |apt_type|
    steps %Q{
      Given "#{first_name}" "#{last_name}" with id "#{student.sid}" signs up for "#{apt_type}"
    }
  end
end


Then /^(?:|I )should see "(.*)" "(.*)" "(.*)"(?: times)$/ do |first_name, last_name, num_times|
  expect(page).to have_content("#{first_name + ' ' + last_name}", count: num_times.to_i)
end

Then /^The tutors should see "(.*)" appointments for "(.*)" "(.*)"$/ do |num_times, first_name, last_name|
  steps %Q{
    Given I am on the student line page
    Then I should see "#{first_name}" "#{last_name}" "#{num_times}" times
   }
end

Given /^"(.*)" "(.*)" with id "(.*)" signs up for "(.*)"$/ do |first_name, last_name, sid, meet_type|
  steps %Q{
    Given I am on the home page
    Then I fill in "student_first_name" with "#{first_name}"
    And I fill in "student_last_name" with "#{last_name}"
    And I fill in "student_sid" with "#{sid}"
    And I click "meet_type_#{meet_type}"
    And I click on "form-submit"
  }
end

Then /^I should see my name on tutor for "(.*)" "(.*)" with id "(.*)" under "(.*)"$/ do |last_name, first_name, id, table|
  pending
end
