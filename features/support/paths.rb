# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name


    when /^the home\s?page$/
      '/'
    when /^the student line page$/ then tutors_path
        #these two routes below render the same thing...will have to modify
    when /^the sign up page$/ then new_student_path
    when /^the student page$/ then students_path
    when /^the history\s?page$/ then history_entries_path
    when /^the tutor firewall page$/ then tutor_firewall_path

    when /^the app firewall page$/ then app_firewall_path
    when /^the wait time page for "(.*)" "(.*)"$/i then
      student = Student.where(:first_name => $1, :last_name => $2)[0]
      student_request = student.student_requests.where(meet_type: "drop-in")[0]
      wait_time_student_request_path(student_request.id)
      
    when /^the confirmation page for "([^"]*)" "([^"]*)"$/ then
      student = Student.where(:first_name => $1, :last_name => $2)[0]
      student_request = student.student_requests.where(meet_type: "drop-in")[0]
      confirm_student_request_path(student_request.id)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
