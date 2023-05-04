module Routing exposing (parseLocation, toUrl)

import Models.Route as Route exposing (Route)
import String
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser exposing ((</>), Parser, map, oneOf, parse, s, top)


parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
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
            absolute [ "league", leagueTitle ] []

        Route.ResultsFixtures leagueTitle ->
            absolute [ "results-fixtures", leagueTitle ] []

        Route.TopScorers leagueTitle ->
            absolute [ "top-scorers", leagueTitle ] []

        Route.NotFound ->
            "404"



-- need to test this


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Route.LeagueList top
        , map Route.LeagueList (s "index.html")
        , map Route.LeagueTable (s "league" </> map urlDecode Url.Parser.string)
        , map Route.ResultsFixtures (s "results-fixtures" </> map urlDecode Url.Parser.string)
        , map Route.TopScorers (s "top-scorers" </> map urlDecode Url.Parser.string)
        ]


urlDecode : String -> String
urlDecode encoded =
    encoded
        |> Url.percentDecode
        |> Maybe.withDefault
            (partialUrlDecode encoded)



-- Should maybe do this with a List of tuples and a fold, but this is easy to read and fine at the moment.
-- The list refactor would be worth doing if we have to repeat the replacements somewhere else (say in an
-- encode function)


partialUrlDecode : String -> String
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


replace : String -> String -> String -> String
replace toReplace replaceWith source =
    String.split toReplace source
        |> String.join replaceWith
