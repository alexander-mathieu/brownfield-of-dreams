![Brownfield of Dreams Screenshot](/rales_engine_screenshot.png?raw=true "Brownfield of Dreams Screenshot")

# Brownfield of Dreams

Welcome to Brownfield of Dreams! This is a brownfield project completed by Brian Plantico, Brennan Ayers and Alexander Mathieu at during Module 3 [Turing School of Software & Design](https://turing.io/).

The deployed site can be viewed [here](https://brownest-field.herokuapp.com/).

Go ahead and make a user account, and see what you can do!

## About

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Requirements
 * [Ruby 2.4.1](https://www.ruby-lang.org/en/downloads/) - Ruby Version
 * [Rails 5.2.0](https://rubyonrails.org/) - Rails Version

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)


## Installation
```
$ git clone https://github.com/alexander-mathieu/brownfield_of_dreams.git
$ cd brownfield_of_dreams
$ bundle install
```

Install Node packages for Stimulus:
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
$ yarn add rails-ujs
```

Set up the database:
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Additionally, you'll need:
 * An API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`
 * An API key with GitHub and have it defined within `ENV['GITHUB-TOKEN']`
 * An API key with SendGrid and have it defined within `ENV['SENDGRID-API-KEY']`
 * A GitHub client ID defined within `ENV['GITHUB-CLIENT-ID']`
 * A GitHub client secret defined within `ENV['GITHUB-CLIENT-SECRET']`

Information on setting up a GitHub client ID/secret can be found [here](https://github.com/settings/apps).

## Running Tests
The full testing suite can be run with `$ bundle exec rspec`.

Example of expected output:
```
..Capybara starting Puma...
* Version 3.12.0 , codename: Llamas in Pajamas
* Min threads: 0, max threads: 4
* Listening on tcp://127.0.0.1:62536
..............................................................................................

Finished in 10.92 seconds (files took 3.96 seconds to load)
96 examples, 0 failures

Coverage report generated for RSpec to /Users/alexandermathieu/turing/mod_3/projects/brownfield-of-dreams/coverage. 1220 / 1232 LOC (99.03%) covered.
```

IF TESTS FAILING/VIDEOS NOT LOADING DUE TO MISSING POSITIONS:
```
$ bundle exec rake videos:set_position_if_missing
```

## Local Exploration
Once installation and database setup are complete, explore the site using the following steps:

 * From the `brownfield_of_dreams` project directory, boot up a server with `rails s`
 * Open your browser, and visit `localhost:3000/`
