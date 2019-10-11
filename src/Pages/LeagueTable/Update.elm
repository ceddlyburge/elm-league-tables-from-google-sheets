module Pages.LeagueTable.Update exposing (refreshLeagueTable, showLeagueTable)

import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Msg exposing (..)
import Pages.UpdateHelpers exposing (refreshRouteRequiringIndividualSheetApi, showRouteRequiringIndividualSheetApi)


showLeagueTable : String -> Model -> ( Model, Cmd Msg )
showLeagueTable leagueTitle model =
    showRouteRequiringIndividualSheetApi
        leagueTitle
        (Route.LeagueTable leagueTitle)
        model


refreshLeagueTable : String -> Model -> ( Model, Cmd Msg )
refreshLeagueTable leagueTitle model =
    refreshRouteRequiringIndividualSheetApi
        leagueTitle
        (Route.LeagueTable leagueTitle)
        model
