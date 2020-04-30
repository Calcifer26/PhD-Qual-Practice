## Heroku Application URL
https://cse-phd-qual-practice.herokuapp.com/

## Setup (4 Steps)
### (1/4) Git Ready
```
git clone https://github.com/Justin-Teng/PhD-Qual-Practice.git
git checkout -b <yourFeature>
```

### (2/4) Install Dependencies
```
nvm i v8 
npm install -g heroku
sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
rvm install ruby-2.4.1
rvm use 2.4.1
gem install rails -v '4.2.8' --no-ri --no-rdoc
bundle install
```

### (3/4) Heroku Deployment
```
heroku login
git init
heroku create
git add .
git commit -m ""
git push heroku master
```

### (4/4) Populate and Run
```
heroku run rake db:migrate
heroku run rake db:seed
heroku open
```
## Updating Heroku DB
```
heroku run rake db:reset
```

## Facebook and Google authentication.
### Create token
For these features to work you have to create your own client_id and secret.
* Follow https://developers.google.com/identity/protocols/oauth2 for google.
* Follow https://developers.facebook.com/docs/facebook-login/access-tokens/ for facebook
### Setting up environment variable.
Set below environement variables using export command( in case of linux),
export FB_APP_ID=***
export FB_APP_SECRET=***
export GOOGLE_APP_ID=***
export GOOGLE_APP_SECRET=***


## Forgot password email sender 
### Setting Up a gmail account
Go to the https://myaccount.google.com/lesssecureapps url from the account you want to use and turn on the toggle switch so it says Allow less secure apps: ON 

### Setting Up environment variable
Either use 
    ```
    export GMAIL_USERNAME=***
    export GMAIL_PASSWORD=***
    ```
Or, create e ```.env``` file on the root and set the  following variables accordingly
    ```
    GMAIL_USERNAME=*** 
    GMAIL_PASSWORD=***
    ```
