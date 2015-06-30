# WarpSpeed Ruby Sinatra Sample Application

[Sinatra](http://http:sinatrarb.com) is a lightweight Ruby Web framework. [WarpSpeed](https://warpspeed.io) makes it incredibly easy to deploy Sinatra and other Ruby based projects. This guide will help you get up and running with Sinatra and WarpSpeed.

## Vagrant Development Environment

This guide assumes that you are using the WarpSpeed Vagrant development environment. Doing so will help you follow best practices and keep your development and production environments as similar as possible.

Throughout this guide commands will need to be run either from within your Virtual Machine (VM) or your local machine environment (outside the VM). Each set of commands will be clearly marked regarding where they should be run. Anytime you need to access your WarpSpeed Vagrant VM, perform the following:

```
# RUN THESE COMMANDS ON YOUR LOCAL MACHINE

# open a terminal and cd to your warpspeed-vagrant directory
cd ~/warpspeed-vagrant

# make sure your VM is running
vagrant up

# SSH into your VM
vagrant ssh
```

## Fork and Clone the Sample Project

The best way to begin using this project is to fork the repository to your own GitHub account. This will allow you to make updates and begin using the project as a template for your own work. To fork the repository, simply click the "Fork" button for this repository.

Once you have forked the repository, you can clone it to your development environment or use pull-deploy to deploy it directly to a server configured with WarpSpeed.io.

To clone the repository to your local machine (not in your VM), perform the following:

```
# RUN THESE COMMANDS ON YOUR LOCAL MACHINE

# access your Sites directory
cd ~/Sites

# clone the forked repository, specifying a name for the directory
git clone git@github.com:YOUR_USERNAME/ruby-sinatra-sample.git warpspeed-sinatra.dev
```

## Create a Database

The sample project uses a MySQL database. This can easily be swapped with an SQLite or PostgreSQL database. To create a MySQL database and user with WarpSpeed, do the following:

```
# RUN THESE COMMANDS IN YOUR VM

# run the db creation command
warpspeed mysql:db tasks_db tasks_user password123

# you will be prompted for the mysql root database password. It is "vagrant".
```

This will create a database named "tasks\_db" along with a user, "tasks\_user", that has access via the password "password123". Feel free to change the values to suit your needs (hint: perhaps choosing a better password would be wise).

## Create a WarpSpeed Site

We need to create the appropriate server configuration files to run the site. To configure Nginx and Passenger, perform the following:

```
# RUN THESE COMMANDS IN YOUR VM

# run the site creation command
# notice that --force is used because the site directory already exists
warpspeed site:create ruby warpspeed-sinatra.dev --force
```

## Install Ruby and Gemfiles

Ruby is not installed natively, but through the ruby environment you can specify and install the proper version of ruby. All of the needed dependencies listed in the Gemfile can then be installed with the bundler.

To install ruby and gemfiles, perform the following:

```
# RUN THESE COMMANDS IN YOUR VM

# make sure you are in the home directory
cd ~/

# install ruby 2.1.4
rbenv install 2.1.4

# make sure you are in your project directory
cd ~/sites/warpspeed-sinatra.dev

# set the local ruby version to 2.1.4
rbenv local 2.1.4

# use the bundler to install gemfiles
bundle install
```

## Configure your App Settings

The Sinatra app needs certain configuration settings that are sensitive, such as an application secret key and your database credentials. These should not be stored in GitHub for obvious reasons. To avoid this, you can use environment variables that get referenced in your app settings. The sample app comes pre-configured this way, so all you need to do is add some new variables into your ruby environment.

```
# RUN THESE COMMANDS IN YOUR VM

# make sure you are in the correct directory
cd ~/sites/warpspeed-sinatra.dev

# create the file for the environment variables
sudo nano .rbenv-vars

# add the following lines
DATABASE_URL=mysql2://tasks_user:password123@localhost/tasks_db
secret=YOUR_SECRET_KEY

# save and exit
```

Now all of your application's environment variables will be available so you can do things like run migrations, etc.

## Run Migrations

We need to create the required tables in the database. To run the migration, perform the following:

```
# RUN THESE COMMANDS IN YOUR VM

# make sure you are in the proper site directory
cd ~/sites/warpspeed-sinatra.dev

# migrate the data into the database
rake db:migrate
```

If the schema is not loaded successfully, it is likely that you have not configured your environment with your database credentials. Please see the "Configure your App Settings" section above for details.

## Add a Hosts File Entry

To access your new Sinatra site, you will need to add an entry to the hosts file on your machine (not in your VM). To do so, perform the following:

```
# RUN THESE COMMANDS ON YOUR LOCAL MACHINE

# open a terminal and run the following command (for Mac)
sudo nano /etc/hosts

# add a line that looks like this to the end of the file
192.168.88.10  warpspeed-sinatra.dev

# save and exit
```

Now, whenever you access "warpspeed-sinatra.dev" in your web browser, you will be directed to your Sinatra site within your VM.

## Restart your Site and Celebrate

Finally, we need to reload the site configuration to make all of the changes we made take effect. Perform the following:
```
# RUN THESE COMMANDS IN YOUR VM

# reload the site configuration
warpspeed site:reload warpspeed-sinatra.dev
```

Now, you can access http://warpspeed-sinatra.dev on your machine to view the site.

## Troubleshooting

If you have issues and need to troubleshoot, you should view the Nginx log file for clues. To do so, perform the following:

```
# RUN THESE COMMANDS IN YOUR VM

# to view the Nginx log file
sudo nano /var/log/nginx/error.log
```

# License

This sample project is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).

