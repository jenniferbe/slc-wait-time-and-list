
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
  steps %Q{
  Given the following student queues exist:
  | first_name      | last_name      | sid        | meet_type  | status  | created_at              |
  | #{last_name}    | #{first_name}  | 25804240   | drop-in    | waiting | 2012-09-10 14:44:24 UTC |
  | #{first_name}   | #{first_name}  | 25804240   | scheduled  | waiting | 2012-09-10 14:44:24 UTC |
  | #{first_name}   | #{first_name}  | 25804240   | weekly     | waiting | 2012-09-10 14:44:24 UTC |
}
end

When /^"(.*)" "(.*)" signs up for any of the three appointments again$/ do |first_name, last_name|
  steps %Q{ Given "#{first_name}" "#{last_name}" is signed up for all three appointments }
end

Then /^The tutors should see "(.*)" appointments for "(.*)" "(.*)"$/ do |num_app, last_name, first_name|

  pending
end

Then /^I should see my name on tutor for "(.*)" "(.*)" with id "(.*)" under "(.*)"$/ do |last_name, first_name, id, table|
  pending
end
