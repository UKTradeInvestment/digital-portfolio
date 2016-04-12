# UKTI Digital Portfolio

This application contains a collection of current work going on within the UKTI Digital team.

## Contributing

Projects are maintained in the [`./data/projects`](./data/projects) directory.

This application will create a portfolio page and an item on the homepage for each file
in this directory.

To **add** an item to the portfolio, create a either a new `.json` or `.yaml` file in this directory.

To **edit** an existing item, amend the file name that matches the last part of the url.

For more details on the data structure of each item, see [project data](#project-data).

**Note:** Please ensure all new commits are created as a branch and
submitted via a [Pull Request](https://help.github.com/articles/using-pull-requests/).

### Project data

Each project is made up of a set of key/value pairs.
This data can be in either [JSON](http://www.json.org/) or [YAML](http://yaml.org/) format.

For a blank example in each format look in the `./examples/` directory.

The current available options for each project are shown in the table below.

#### Project schema

| Key         | Description                                                                                                                                        | Type                                                         |
|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| name        | The name of the product/service.                                                                                                                   | String                                                       |
| description | A short description of the product/service. This is displayed on the listing page and at the top of the item page.                                 | Text                                                         |
| theme       | The area of the business the product/service falls into.                                                                                           | String                                                       |
| phase       | The phase the product/service is in. See the [service design phases](https://www.gov.uk/service-manual/phases) for more information on each phase. | String. **Valid options:** Backlog/Discovery/Alpha/Beta/Live |
| people      | A list of key people associated with the product/service. See [person schema](#person-schema) for the structure of each list item.                 | Array                                                        |
| repository  | A link to the source code of the product/service.                                                                                                  | String                                                       |
| url         | A link to the product/service if it's currently live.                                                                                              | String                                                       |
| history     | A collection of recent updates on the product/service. See [history schema](#history-schema) for the structure of each list item.                  | Object                                                       |

#### Person schema

| Key      | Description                                                 | Type   |
|----------|-------------------------------------------------------------|--------|
| position | The position held by the person                             | String |
| name     | The name of the person. Doesn't have to be their full name. | String |

#### History schema

| Key       | Description                                                                                                                       | Type  |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------|-------|
| discovery | Updates associated with the Discovery phase. See [history item schema](#history-item-schema) for the structure of each list item. | Array |
| alpha     | Updates associated with the Alpha phase. See [history item schema](#history-item-schema) for the structure of each list item.     | Array |
| beta      | Updates associated with the Beta phase. See [history item schema](#history-item-schema) for the structure of each list item.      | Array |
| live      | Updates associated with the Live phase. See [history item schema](#history-item-schema) for the structure of each list item.      | Array |

#### History item schema

| Key      | Description                                                   | Type        |
|----------|---------------------------------------------------------------|-------------|
| label    | The description of what happened                              | String      |
| date     | The date it occurred. Preferred format `MM YYYY`, eg Nov 2015 | Date string |
| complete | Whether this has happened or is in progress                   | Boolean     |

## Installation

### Dependencies

* [Ruby](https://www.ruby-lang.org/en/)
* [Node.js](https://nodejs.org/en/)
* [Foreman](http://ddollar.github.io/foreman/) (for development only)

This prototype is based on [middleman](https://middlemanapp.com/), a static site generator,
and [mojular](https://github.com/mojular) for common [GOV.UK](https://gov.uk/) layouts and patterns.

1. Clone repository:

  ```
  git clone https://github.com/UKTradeInvestment/digital-portfolio
  ```

2. Install ruby dependencies:

  ```
  bundle install
  ```

3. Install node dependencies:

  ```
  npm install
  ```

4. Build static files from source to `./build/`:

  ```
  middleman build
  ```

  **OR**

  Run a middleman server

  ```
  middleman server
  ```

## Deployment

The application is deployed to [Heroku](http://heroku.com/) where it runs a [rack](http://rack.github.io/) application serving the static files.

The [production environment](https://ukti-digital-portfolio.herokuapp.com/) is automatically deployed on changes to the `master` branch.

Heroku's [review apps beta](https://blog.heroku.com/archives/2015/5/19/heroku_review_apps_beta) is being used to create new instances for each [Pull Request](https://help.github.com/articles/using-pull-requests/) created.

If a more stable environment is required, for example, for a lab testing session, a new Heroku instance can be created on the fly and a specific branch can be deployed.

The site may be protected by a username and password. If you have access to the Heroku app these will be stored as environment variables.

If you have the [Heroku toolbelt](https://toolbelt.heroku.com/) installed you can check environment variables by running:

```
heroku config
```

## Development

Assets are compiled using [webpack](https://webpack.github.io/). [Foreman](http://ddollar.github.io/foreman/) can be used to simultaneously run a middleman server and a webpack module bundler.

Run:

```
foreman start --procfile dev.Procfile
```
