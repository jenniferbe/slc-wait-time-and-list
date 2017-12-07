## CodeClimate GPA Badge
[![Code Climate](https://codeclimate.com/github/rails/rails/badges/gpa.svg)](https://codeclimate.com/github/villegsa/slc-wait-time)
## CodeClimate Code Coverage Badge
[![Test Coverage](https://api.codeclimate.com/v1/badges/7f456195a0d9bbc0a5f2/test_coverage)](https://codeclimate.com/github/villegsa/slc-wait-time/test_coverage)
## Travis-ci Build Status
[![Build Status](https://travis-ci.org/villegsa/slc-wait-time.svg?branch=master)](https://travis-ci.org/villegsa/slc-wait-time)
## Heroku
[slc-wait-time-and-list](https://slc-wait-time-and-list.herokuapp.com/ "slc-wait-time-and-list")
## Pivotal Tracker
[Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2118568 "pvt")
## Description
This application allows students to check in for UC Berkeley's Student Learning Center. 
Students can sign in for their scheduled appointments or add their name into the queue for drop-in sessions. 
Tutors are given an interface to work and record their tutoring sessions with these students. The Application also allows tutors to check-in and check-out of their shifts, giving them an easy way to clock their hours.
Admins have full control over the application allowing them to look through and manage the past records and create tutor accounts.  

This link below shows the old form that the SLC used to use. The information recorded is what we based part of our database on. [Student Learning Center](https://berkeley.mywconline.com/ "slc")

## Running the App
First install gpg
```sh
$ brew install gnupg
```
Next, enter the key that is provided. This key decrypts the application.yml.asc
Inside you will find the password to the SLC overall application lock. Anytime you change in the application.yml make sure to re-encrypt it with the following link to Armando Fox's [gpg guide](https://saasbook.blogspot.com/2016/08/keeping-secrets.html). 

```sh
$ export KEY=your-secret-key-value
$ gpg --passphrase "$KEY" --decrypt \
   --output config/application.yml  config/application.yml.asc
```

To get the app to run, set it up with
```sh
$ bundle install --without production
$ rake db:setup db:migrate
```
And then you can run it on your local browser
```sh
$ rails s
```
or with Cloud 9
```sh
$ rails s -p $PORT -b $IP
```
## Issue
Don't why it is at the moment, but if this codebase gets revived, look into the email confirmation when a student accepts the wait time for drop in. For some reason the email sometimes takes 10 seconds or more to send. I'm sure there's a performance fix, but most importantly the email needs to be sent asynchronously. - Alex
