module Pages.TopScorers.Update exposing (showTopScorers, refreshTopScorers)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (showRouteRequiringIndividualSheetApi, refreshRouteRequiringIndividualSheetApi)

showTopScorers : String -> Model -> ( Model, Cmd Msg )
showTopScorers leagueTitle model  =
    showRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.TopScorers leagueTitle)
        model 

refreshTopScorers : String -> Model -> ( Model, Cmd Msg )
refreshTopScorers leagueTitle model  =
    refreshRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.TopScorers leagueTitle)
        model 