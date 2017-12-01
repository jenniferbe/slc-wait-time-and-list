
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

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
    expect(student.student_requests.where(:meet_type => "drop-in")[0].status).to eq("cancelled")
  else
    expect(student.student_requests.where(:meet_type => "drop-in")[0].status).to eq("waiting")
  end
end

And /^(?:she|he?) clicks on "(.*)"$/ do |button|
  steps %Q{ When follow "#{button}"}
end

Given /^I specify "(.*)"$/ do |string|
  pending
end
