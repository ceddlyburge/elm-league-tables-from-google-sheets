This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

Below you will find some information on how to perform basic tasks.
You can find the most recent version of this guide [here](https://github.com/halfzebra/create-elm-app/blob/master/template/README.md).

# Building

- npm install
- npm run build

# Netlify Build

Netlify detects the package.json and runs npm install automatically. It caches the results of this and then uses the cache in subsequent builds. However the cache doesn't seem clever enough to take in to account the postinstall script (or maybe it doesn't know about elm-packages and so doesn't cache them). Either way, it stops working after the first build.

`npm run netlifybuild` is used on netlify, which sorts this problem out.

# End to end test coverage

The "End to End" tests don't cover everything, and I think don't test the app as deployed. It is possible to do this in Elm via Selenium, but its a bit of a faff so I've compromised.

The following are not covered, so need to do manual testing when changing them

- ./Main.elm
- ./index.js

It doesn't seem possible to have a separate elm-package.json for the EndToEndTests (in the way that the normal `tests` folder has). I tried to make this work and failed, so I have had to pollute the main elm-package.json with things that the EndToEndTests need. I don't think this is a disaster.