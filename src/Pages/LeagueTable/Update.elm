module Pages.LeagueTable.Update exposing (individualSheetRequest)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Pages.UpdateHelpers exposing (showRouteRequiringIndividualSheetApi)

individualSheetRequest : String -> Model -> ( Model, Cmd Msg )
individualSheetRequest leagueTitle model  =
    showRouteRequiringIndividualSheetApi 
        leagueTitle 
        (Route.LeagueTableRoute leagueTitle)
        model 