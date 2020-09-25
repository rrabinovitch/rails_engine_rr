# RailsEngine

**About this Project:**
RailsEngine is a versioned, ReSTful, JSON API for sales data. It exposes record, relationship, and business intelligence endpoints for various sales-related resources.

This solo project was build for [Mod3](https://backend.turing.io/module3/) of Turing School of Software and Design's [Back-End Program](https://backend.turing.io/).

**Project premise:** You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

[RailsDriver](https://github.com/rrabinovitch/rails_driver) is an example (provided by Turing instructors) for how this RailsEngine API could be consumed.

*_Explore a similar project I completed for my third quarter final at Turing [here](https://github.com/rrabinovitch/sweater_weather)_

## Schema diagram
![schema diagram](https://user-images.githubusercontent.com/62635544/92130499-0d40a480-edc2-11ea-968d-0189e0a6eab4.png)

## Local Setup
1. Create a root directory that will house this repo and the front-end application, [RailsDriver](https://github.com/rrabinovitch/rails_driver).
2. Clone this RailsEngine repo within your root directory:
`git clone git@github.com:rrabinovitch/rails_engine_rr.git`
3. RailsEngine configuration + creating and seeding your database:
    * `bundle install`
    * `rake db:{create, migrate}`
    * `rake seed_from_csv:all`
5. Clone [RailsDriver](https://github.com/rrabinovitch/rails_driver) within your root directory: `git clone git@github.com:rrabinovitch/rails_driver.git`
6. RailsDriver configuration:
    * `bundle install`
    * `rake db:{create, migrate}`
    * `figaro install`
    * Within the `config/application.yml` file that this last command created, add the key-value pair `RAILS_ENGINE_DOMAIN: http://localhost:3000`

## Testing
* To run the RailsDriver test suite: run `bundle exec rspec` from within the RailsDriver directory
* To run the RailsEngine spec harness:
    * From within the RailsEngine directory, launch the local server: `rails s`
    * From within the RailsDriver directory (in another terminal window), run `bundle exec rspec`
    * _Note: As of September 3, 2020 there are 2 business intelligence tests in the spec harness not yet passing_

## API Consumption
You can see this API in action through the front-end RailsDriver application, Postman, or in your browser.
* Consumption via RailsDriver:
    * From within the RailsEngine directory, launch the local server: `rails `
    * From within the RailsDriver directory (in another terminal window), launch the server on another port: `rails s - 3001`
    * Navigate your browser to `localhost:3001` and explore!
* Consumption via Postman
    * Check out my Postman collection [here](https://www.postman.com/collections/da1d052829d18626e5cd) to see a snapshot of the unique endpoints available via this API.
* View the endpoints via browser
    * From within the RailsEngine directory, launch the local server: `rails s`
    * Explore the endpoints listed here by prefixing them with `localhost:3000/api/v1`
         * A few quick examples you could try: `GET /items` • `GET /merchants` • `GET /merchants/most_revenue?quantity=7`
               

### [Endpoint Documentation](https://github.com/rrabinovitch/rails_engine_rr/blob/master/endpoint_documentation.md#endpoints)
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/da1d052829d18626e5cd)
* responses are JSON API 1.0 Compliant
* GET requests require params submitted via query params
* POST requests require params submitted via the request body
* if exploring endpoints locally, make sure to first follow the [local set up instructions](https://app.getpostman.com/run-collection/da1d052829d18626e5cd) and run `rails s`
