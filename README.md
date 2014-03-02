# Artist Spaces

Web application that helps artists that need a place to rehearse or practice thier favorite skill to meetup with owners who have space available to lease out hourly.


## Installation

After you download the repo, create a .env.local folder and create the appropiate key values. If no keys are available, you will have to comment out the html in app/views/shared/picform.html.erb data.

Then run the following commands.

1) bundle

2) rake db:create

3) rake db:migrate

4) rake db:seed (optional- seed database with fake data)

5) rails server

Open browser and use 'localhost:3000' in the URL

## About

We used Ruby 2.0.0 and Rails 4.0.2 for this project, dependant on AWS and Stripe services.

## Heroku

We are currently have heroku temporarily hosting our site, can be found here: [ArtSpace](http://agile-sea-2416.herokuapp.com/)

## Contributors

[Ben](https://github.com/bneuman619), [Kevin](https://github.com/KevinFalank), [Laura](https://github.com/ballauriena), [Shawn](https://github.com/Carpk)
