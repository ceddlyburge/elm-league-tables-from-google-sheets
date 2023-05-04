module Pages.ResultsFixtures.Update exposing (refreshResultsFixtures, showResultsFixtures)

import Models.Model exposing (Model)
import Models.Route as Route
import Msg exposing (Msg)
import Pages.UpdateHelpers exposing (refreshRouteRequiringIndividualSheetApi, showRouteRequiringIndividualSheetApi)


showResultsFixtures : String -> Model -> ( Model, Cmd Msg )
showResultsFixtures leagueTitle model =
    showRouteRequiringIndividualSheetApi
        leagueTitle
        (Route.ResultsFixtures leagueTitle)
        model


refreshResultsFixtures : String -> Model -> ( Model, Cmd Msg )
refreshResultsFixtures leagueTitle model =
    refreshRouteRequiringIndividualSheetApi
        leagueTitle
        (Route.ResultsFixtures leagueTitle)
        model
