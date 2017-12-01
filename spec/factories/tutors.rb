FactoryGirl.define do
  factory :tutor do
    email "example@google.com"
    password "password"
    password_confirmation "password"
    first_name "MyString"
    last_name "MyString"
    sid 1
  end
end
