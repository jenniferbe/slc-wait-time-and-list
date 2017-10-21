
Given /^"([^"]*)" "([^"]*)" is on the wait time page$/ do |first_name, last_name|
    steps %Q{
        Given I am on the sign up page
        Then I fill in "student_first_name" with "#{first_name}"
        And I fill in "student_last_name" with "#{last_name}"
        And I fill in "student_sid" with "123456"
        And I click on "form_submit"
        Then I should be on the wait time page
    }
end

Given /^"([^"]*)" "([^"]*)" is already in line$/ do |first_name, last_name| 
    steps %Q{
        Given "Jennifer" "Be" is on the wait time page
        And she clicks on "yes"
        Given "Jennifer" "Be" is on the wait time page
    }
end

And /^(?:she|he?) clicks on "(.*)"$/ do |button| 
    steps %Q{ When I click on "#{button}"}
end
