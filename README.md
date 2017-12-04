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
Tutors are given an interface to work and record their tutoring sessions with these students. 
Admins have full control over the application allowing them to look through and manage the past records and create and tutor accounts.  

This link below shows the old form that the SLC used to use. THe information recorded is what we based part of our database on. [Student Learning Center](https://berkeley.mywconline.com/ "slc")

## Running the App
First we have to install gpg
```sh
$ brew install gnupg
```
Then enter the key that we can provide to you that decrypts application.yml.asc
Inside you will find the password to the SLC overall application lock. Anything you change in the application.yml make sure to re-encrypt it with this link to Armando Fox's [gpg guide](https://saasbook.blogspot.com/2016/08/keeping-secrets.html). 

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
And then you should be able to run it on your local browser
```sh
$ rails s
```
or with Cloud 9
```sh
$ rails s -p $PORT -b $IP
```
