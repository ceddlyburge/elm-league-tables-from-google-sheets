module Routing exposing (parseLocation, toUrl)

import Navigation exposing (Location)
import Models.Route as Route exposing (Route)
import UrlParser exposing (..)


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            Route.NotFoundRoute

-- This doesn't encode the strings, which is a shame, and means that it won't always match what happens in the browser
toUrl : Route -> String
toUrl route =
    case route of
        Route.LeagueListRoute ->
            "/"

        Route.LeagueTableRoute leagueTitle ->
            "/league/" ++ leagueTitle
        
        Route.ResultsFixturesRoute leagueTitle ->
            "/results-fixtures/" ++ leagueTitle
        
        Route.NotFoundRoute ->
            "404"

-- need to test this
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Route.LeagueListRoute top
        , map Route.LeagueListRoute (s "index.html")
        , map Route.LeagueTableRoute (s "league" </> string)
        , map Route.ResultsFixturesRoute (s "results-fixtures" </> string)
        ]
