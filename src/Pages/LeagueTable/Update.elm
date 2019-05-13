module Pages.LeagueTable.Update exposing (showLeagueTable, refreshLeagueTable)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (showRouteRequiringIndividualSheetApi, refreshRouteRequiringIndividualSheetApi)

showLeagueTable : String -> Model -> ( Model, Cmd Msg )
showLeagueTable leagueTitle model  =
    showRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.LeagueTableRoute leagueTitle)
        model 

refreshLeagueTable : String -> Model -> ( Model, Cmd Msg )
refreshLeagueTable leagueTitle model  =
    refreshRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.LeagueTableRoute leagueTitle)
        model 