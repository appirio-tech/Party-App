# Deployment Instructions

This is a basic rundown of what you will need to do in order to get the
Party app up and running on Heroku.

1. In the root of the project, run `heroku create appname --stack cedar`. 
   This should add a git remote called "heroku" that will point to the 
   Heroku deployment endpoint.
2. Get your application deployed with `git push heroku master`
3. Set up **environment variables** as described below.
3. Migrate the database: `heroku run rake db:migrate`
4. Visit `appname.herokuapp.com` and enter the admin username and
   password you set in the environment variables.
5. Create a new conference, setting the domain to a domain that you
   control.
6. Point the DNS for that domain either to the appropriate Heroku DNS IP
   or, if you can CNAME, to appname.heroku.com.
7. Add the custom domains addon to the app: `heroku addons:add
   custom_domains`
8. Add the domain(s) you need for your conferences to the app:
   `heroku domains:add parties.mydomain.com`
9. Now when you visit `parties.mydomain.com` it should show the
   conference name you gave it in the admin section. Note that at any
   given domain you can only see the parties for that conference.

## Environment Variables

Heroku uses environment variables as a way to remove possibly sensitive
access keys etc. from code but still have them accessible. I like to use
environment variables for various configuration options in my
application. To set an environment variable (or multiple) you do this:

    heroku config:add VARIABLE_NAME="Variable Value" VARIABLE2_NAME=".."

Here's a list of the config variables for Partay:

* TWITTER_KEY: Your Twitter consumer key.
* TWITTER_SECRET: Your Twitter consumer secret.
* SALESFORCE_KEY: Your Salesforce OAuth key.
* SALESFORCE_SECRET: Your Salesforce OAuth secret.
* ADMIN_DOMAIN: The hostname (e.g. appname.herokuapp.com) that you want
  to use to access the admin interface.
* ADMIN_USER: The username you want to protect the admin section.
* ADMIN_PASSWORD: The password you want to protect the admin section.
* ADMIN_EMAIL: The email address you want to send approval notices to.
* S3_KEY: The Amazon S3 access key (for image storage).
* S3_SECRET: The Amazon S3 secret.

Once you've set all of these variables up, you should be able to run and
use the application.
