module Routing exposing (parseLocation, toUrl)

import String exposing (split, join)
import Navigation exposing (Location)
import Models.Route as Route exposing (Route)
import UrlParser exposing (..)
import Http

parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            Route.NotFound


toUrl : Route -> String
toUrl route =
    case route of
        Route.LeagueList ->
            "/"

        Route.LeagueTable leagueTitle ->
            "/league/" ++ Http.encodeUri leagueTitle
        
        Route.ResultsFixtures leagueTitle ->
            "/results-fixtures/" ++ Http.encodeUri leagueTitle
        
        Route.NotFound ->
            "404"

-- need to test this
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Route.LeagueList top
        , map Route.LeagueList (s "index.html")
        , map Route.LeagueTable (s "league" </> (map urlDecode string))
        , map Route.ResultsFixtures (s "results-fixtures" </> (map urlDecode string))
        ]

urlDecode: String -> String
urlDecode encoded = 
    encoded
    |> Http.decodeUri
    |> Maybe.withDefault
        (partialUrlDecode encoded)

-- Should maybe do this with a List of tuples and a fold, but this is easy to read and fine at the moment.
-- The list refactor would be worth doing if we have to repeat the replacements somewhere else (say in an
-- encode function)
partialUrlDecode: String -> String
partialUrlDecode encoded = 
    encoded
    |> replace "%20" " "
    |> replace "%21" "!"
    |> replace "%23" "#"
    |> replace "%24" "$"
    |> replace "%26" "&"
    |> replace "%27" "'"
    |> replace "%28" "("
    |> replace "%29" ")"
    |> replace "%2A" "*"
    |> replace "%2B" "+"
    |> replace "%2C" ","
    |> replace "%2F" "/"
    |> replace "%3A" ":"
    |> replace "%3B" ";"
    |> replace "%3D" "="
    |> replace "%3F" "?"
    |> replace "%40" "@"
    |> replace "%5B" "["
    |> replace "%5D" "]"

replace: String -> String -> String -> String
replace toReplace replaceWith source = 
    String.split toReplace source
    |> String.join replaceWith

