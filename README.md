This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

# Development

- `npm install`
- `npm run start:server`
- `npm run start:app`

- `elm-app test` will run the unit tests
- `npm cypress open` will open the cypress test runner, for debugging / running the end to end tests interactively
- `cypress run` will run the end to end tests
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

[![Netlify Status](https://api.netlify.com/api/v1/badges/34b6a5a7-0314-4cea-9284-f46d213986c5/deploy-status)](https://app.netlify.com/sites/league-tables-development/deploys)

# Deployment

There are various deployments of this code on Netlify, most of which deploy whenever there is a push to the master branch, or a pull request. You can create a new deployment using the button below. 

The Netlify build process only runs the unit tests, so make sure the Appveyor build passes before merging in to master.

You will need to create a (free) Netlify account if you haven't already got one, and you will need to enter the following things

- The url of an Icon that will be used for the favicon and the manifest. You can use [this one](https://raw.githubusercontent.com/ceddlyburge/CanoePoloLeagueOrganiser/master/CanoePoloLeagueOrganiserXamarin/Resources/drawable/canoe_polo_ball.png) if you like
- The title ("League Tables" or similar)
- The [Spreadsheet Id](https://developers.google.com/sheets/api/guides/concepts#spreadsheet_id) of the Google Sheet to use as the source of the Data. This sheet [must be published](https://support.google.com/docs/answer/183965). You can use the test one if you like (1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE)
- A [Google Api Key](https://developers.google.com/maps/documentation/javascript/get-api-key)

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/ceddlyburge/elm-league-tables-from-google-sheets)

