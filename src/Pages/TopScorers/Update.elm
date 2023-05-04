module Pages.TopScorers.Update exposing (refreshTopScorers, showTopScorers)

import Models.Model exposing (Model)
import Models.Route as Route
import Msg exposing (Msg)
import Pages.UpdateHelpers exposing (refreshRouteRequiringIndividualSheetApi, showRouteRequiringIndividualSheetApi)


showTopScorers : String -> Model -> ( Model, Cmd Msg )
showTopScorers leagueTitle model =
    showRouteRequiringIndividualSheetApi
        leagueTitle
        (Route.TopScorers leagueTitle)
        model


refreshTopScorers : String -> Model -> ( Model, Cmd Msg )
refreshTopScorers leagueTitle model =
    refreshRouteRequiringIndividualSheetApi
        leagueTitle
        (Route.TopScorers leagueTitle)
        model
