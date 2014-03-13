BEN NEUMAN FORK INFORMATION:

I was responsible for the code relating to the calendar and scheduling. The front-end code appears in app/assets/javascripts/calendar. It depends on the JQuery Week Calendar (calendar/lib). The views (with a little inline JS) appear in app/views/shared/*_calendar.html.erb. The relevant controllers are all the helper files in app/controllers (AvailabilitiesHelpers, ReservationsHelpers, CalendarHelpers), everything in AvailabilitiesController, ReservationsController#create, and the calendar lines in SpacesController#show.



# ArtSpace


Artspace dissolves an information barrier between artists and art advocates.
It enables advocates to showcase their spaces and expedite the scheduling process. 
Artists can locate and secure the space they need in one place.



## Installation


After you download the repo, populate the .env.development file with the following keys:

ARTSPACE_CLIENT_ID= {the Stripe app client ID}

ARTSPACE_SECRET_API_KEY= {the Stripe secret app key}

AWS_ACCESS_KEY_ID= {amazon web service S3 access keys}

AWS_SECRET_ACCESS_KEY= {amazon web service S3 access keys}

AWS_BUCKET= {name of the folder where you're storing the photos}

If no AWS* keys are available, you will have to comment out the html in app/views/shared/picform.html.erb data.

ARTSPACE* keys are required.


Then run the following commands.

1) bundle

2) rake db:create

3) rake db:migrate

4) rake db:seed (optional- seed database with fake data)

5) rails server

Open browser and use 'localhost:3000' as the URL

## About

We used Ruby 2.0.0 and Rails 4.0.2 for this project, dependent on AWS and Stripe services.
You must subscribe to these services in order to run the project.

## Heroku

Our site is temporarily being hosted on heroku, and can be found here: 
[ArtSpace](http://artspace.herokuapp.com/)

## Contributors

[Ben](https://github.com/bneuman619), [Kevin](https://github.com/KevinFalank), [Laura](https://github.com/ballauriena), [Shawn](https://github.com/Carpk)
