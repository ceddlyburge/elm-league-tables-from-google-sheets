This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

Below you will find some information on how to perform basic tasks.
You can find the most recent version of this guide [here](https://github.com/halfzebra/create-elm-app/blob/master/template/README.md).

# Building

- npm install
- npm run build

# Netlify Build

Netlify detects the package.json and runs npm install automatically. It caches the results of this and then uses the cache in subsequent builds. However the cache doesn't seem clever enough to take in to account the postinstall script (or maybe it doesn't know about elm-packages and so doesn't cache them). Either way, it stops working after the first build.

`npm run netlifybuild` is used on netlify, which sorts this problem out.

# Deployment

There are various deployments of this code on Netlify, most of which deploy whenever there is a push to the master branch, or a pull request. You can create a new deployment using the button below. You will need a (free) Netlify account. There are 3 optional settings, and you must enter a [Google Api Key](https://developers.google.com/maps/documentation/javascript/get-api-key)

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/ceddlyburge/elm-league-tables-from-google-sheets)

