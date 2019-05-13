module Pages.ResultsFixtures.Update exposing (showResultsFixtures, refreshResultsFixtures)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (showRouteRequiringIndividualSheetApi, refreshRouteRequiringIndividualSheetApi)

showResultsFixtures : String -> Model -> ( Model, Cmd Msg )
showResultsFixtures leagueTitle model  =
    showRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.ResultsFixturesRoute leagueTitle)
        model 

refreshResultsFixtures : String -> Model -> ( Model, Cmd Msg )
refreshResultsFixtures leagueTitle model  =
    refreshRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.ResultsFixturesRoute leagueTitle)
        model 