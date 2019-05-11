module Pages.ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (showRouteRequiringIndividualSheetApi)

individualSheetRequestForResultsFixtures : String -> Model -> ( Model, Cmd Msg )
individualSheetRequestForResultsFixtures leagueTitle model  =
    showRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.ResultsFixturesRoute leagueTitle)
        model 