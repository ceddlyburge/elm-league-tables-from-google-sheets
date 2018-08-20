module Routing exposing (parseLocation)

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


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Route.LeagueListRoute top
        , map Route.LeagueTableRoute (s "league" </> string)
        ]
