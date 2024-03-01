[![codecov](https://codecov.io/gh/ceddlyburge/elm-league-tables-from-google-sheets/branch/master/graph/badge.svg)](https://codecov.io/gh/ceddlyburge/elm-league-tables-from-google-sheets)

This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

# Development

- Create a `.env` file (see [.env.template](.env.template) for details), which needs at least [Google Api Key](https://developers.google.com/maps/documentation/javascript/get-api-key).

- `npm install`
- `npm run start:server`
- `npm run start:app`

- `elm-app test` will run the unit tests
- `npm cypress:open` will open the cypress test runner, for debugging / running the end to end tests interactively
- `npm cypress:run` will run the end to end tests
- `npm test` will run the unit and the end to end tests

# Building

- npm install
- npm run build

[![Build status](https://ci.appveyor.com/api/projects/status/2a2vfr5dau7rquob?svg=true)](https://ci.appveyor.com/project/ceddlyburge/elm-league-tables-from-google-sheets)

# Netlify Build

Netlify detects the package.json and runs npm install automatically. It caches the results of this and then uses the cache in subsequent builds. However the cache doesn't seem clever enough to take in to account the postinstall script (or maybe it doesn't know about elm-packages and so doesn't cache them). Either way, it stops working after the first build.

`npm run netlifybuild` is used on netlify, which sorts this problem out.

[![Netlify Status](https://api.netlify.com/api/v1/badges/ff3ad710-5201-40bb-b9ef-0dd077dd8f4a/deploy-status)](https://app.netlify.com/sites/se-polo-2018/deploys)

[![Netlify Status](https://api.netlify.com/api/v1/badges/a09c65ca-8139-4aa4-93f6-87da2ad62079/deploy-status)](https://app.netlify.com/sites/se-polo-2019/deploys)

# Deployment

There are various deployments of this code on Netlify, most of which deploy whenever there is a push to the master branch, or a pull request. You can create a new deployment using the button below.

The Netlify build process only runs the unit tests, so make sure the Appveyor build passes before merging in to master.

# Creating a new deployment

You can create a new league website by simply deploying this code to Netlify, using the button below. You will need to create a (free) Netlify account if you haven't already got one, and you will need to enter the following things

- The url of an Icon that will be used for the favicon and the manifest. You can use [this one](https://raw.githubusercontent.com/ceddlyburge/CanoePoloLeagueOrganiser/master/CanoePoloLeagueOrganiserXamarin/Resources/drawable/canoe_polo_ball.png) if you like
- The title ("League Tables" or similar)
- The [Spreadsheet Id](https://developers.google.com/sheets/api/guides/concepts#spreadsheet_id) of the Google Sheet to use as the source of the Data. This sheet [must be published](https://support.google.com/docs/answer/183965). You can use the test one if you like (1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE)
- A [Google Api Key](https://developers.google.com/maps/documentation/javascript/get-api-key)

Then you can click this button and follow the instructions.

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/ceddlyburge/elm-league-tables-from-google-sheets)

# Carbon emissions

The [usage_scenario.yml](./usage_scenario.yml) file is used with the [Green Metrics Tool](https://metrics.green-coding.berlin/index.html) from Green Coding Berlin to analyse how much carbon is emitted when using the website. It tracks the emissions from running the cypress tests, which visit every page in the website, so effects of changes can be easily monitored. The lambda and the calls the the google api are not included in this.

You can see some results on the [Green Metrics Tool webiste](https://metrics.green-coding.berlin/stats.html?id=ad7de4a7-9a63-4970-ac00-3bea04843d1b)

The usage_scenario.yml is a very similar format to the docker_compose.yml, so you can run `docker compose up --build --abort-on-container-exit --exit-code-from cypress` to debug locally.

Submitting runs is currently a manual process, and can be done using the [Certify New Software form](https://metrics.green-coding.berlin/request.html).
