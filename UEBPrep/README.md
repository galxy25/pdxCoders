#pdxCoders/UEBPrep
##Build Status
 [![Circle CI](https://circleci.com/gh/galxy25/pdxCoders/tree/staging-beta.svg?style=svg)]


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
    Copy over the application.yml file
    $> mv /path/to/appliction.yml ./config
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
 
##Source Control Process: Feature Branch Workflow
* Production branch ---> master
* Branch for development work ---> development
* Branch for testing environment server ---> staging-beta
* Branch prefixes: chores|features|bugs|spikes|releases|hotfixes

Typical developer flow:

    $> git checkout development
    $> git pull
    $> git checkout -b features/story_name_1234
Where 1234 == Story ID in Pivotal Tracker

After you finish work on your branch, create a pull request, leave commits, and after at least one other person has signed off with a 'LGTM'(Looks Good To Me) you may merge it into staging beta, which will then push the changes  to development if all the tests pass. 

[Feature Branch Workflow In Depth Explanation](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)

Merges to production/master will be handled by the team lead. 
