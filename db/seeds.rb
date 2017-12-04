# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
students = [{:first_name => "Alex", :last_name => "Yang", :sid => 254122222, :transfer_student => false, :concurrency_student => false},
            {:first_name => "Haggai", :last_name => "Kaunda", :sid => 213412312, :transfer_student => false, :concurrency_student => false},
            {:first_name => "Maiki", :last_name => "Rainton", :sid => 333333333, :transfer_student => false, :concurrency_student => false},
            {:first_name => "Nahrae", :last_name => "Seok", :sid => 111111111, :transfer_student => false, :concurrency_student => false},
            {:first_name => "Salvador", :last_name => "Villegas", :sid => 555555555, :transfer_student => false, :concurrency_student => false}]

students.each do |student|
  if Student.where(:sid => student[:sid]).empty?
  Student.create!(student)
  end
end

tutors = [{:first_name => 'Jennifer', :last_name => 'Be', :sid => 444444444, :password => 444444444, :email => 'jb@yahoo.com', :admin => false},
          {:first_name => 'Haggai', :last_name => 'Kaunda', :sid => 1234567, :password => 1234567, :admin => true, :email => 'hk@yahoo.com'}]

tutors.each do |tutor|
  if Tutor.where(:sid => tutor[:sid])
  Tutor.create!(tutor)
  end
end


# counter = 0
# students.each do |student|
#   StudentRequest.create!(:student_id=>student[:sid], :course => "english", :created_at => "2017-10-23 01:3#{counter}:58 UTC")
#   counter = counter + 1
# end
