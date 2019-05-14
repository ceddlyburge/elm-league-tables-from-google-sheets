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
            Route.NotFound

-- This doesn't encode the strings, which is a shame, and means that it won't always match what happens in the browser
toUrl : Route -> String
toUrl route =
    case route of
        Route.LeagueList ->
            "/"

        Route.LeagueTable leagueTitle ->
            "/league/" ++ leagueTitle
        
        Route.ResultsFixtures leagueTitle ->
            "/results-fixtures/" ++ leagueTitle
        
        Route.NotFound ->
            "404"

-- need to test this
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Route.LeagueList top
        , map Route.LeagueList (s "index.html")
        , map Route.LeagueTable (s "league" </> string)
        , map Route.ResultsFixtures (s "results-fixtures" </> string)
        ]
