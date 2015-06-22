#pdxCoders/UEBPrep
Build Status: [![Circle CI](https://circleci.com/gh/galxy25/pdxCoders/tree/staging-beta.svg?style=svg)]


##Developer Environment Setup
*Prerequisites* 

* Vagrant Software
* VirtualBox Software 
* GitHub account && access to project repo
* Copy of uebprep.box
* Copy of application.yml (environment variables and secret keys)

*Steps(nix computers)*
     
    Clone the repository 
    $> git clone https://github.com/galxy25/pdxCoders.git
    Move to the application code  directory 
    $> cd pdxCoders/UEBPREP
    Create a virtual machine environment 
    $> vagrant box add ueb /path/to/uebprep.box --force
    Initialize your virtual machine 
    $> vagrant up
    Ssh to the running machine
    $> vagrant ssh
    Install gems for the project
    $> bundle install
    Set up your database
    $> bundle exec rake db:drop db:create db:migrate
    Add initial data for db
    $> bundle exec rake db:seed

For window developers, much of the steps are the same, see: [Windows Vagrant Setup](http://www.sitepoint.com/getting-started-vagrant-windows/)

##Running the application

    Start both the app and delayed job threads 
    $> bundle exec foreman s -f Procfile-dev

##Testing
Run one of two commands to run the complete test suite for   the app

    $> bundle exec rspec
    --or---
    $> bundle exec rake test
 

