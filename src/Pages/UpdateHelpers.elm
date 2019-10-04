module Pages.UpdateHelpers exposing
    ( individualSheetResponse
    , refreshRouteRequiringIndividualSheetApi
    , showRouteRequiringIndividualSheetApi
    )

import Calculations.LeagueFromLeagueGames exposing (calculateLeague)
import Dict exposing (Dict)
import GoogleSheet.Api exposing (fetchIndividualSheet)
import Models.Config exposing (Config)
import Models.LeagueGames exposing (LeagueGames)
import Models.Model exposing (Model)
import Models.Route as Route exposing (Route)
import Msg exposing (..)
import RemoteData exposing (WebData)


showRouteRequiringIndividualSheetApi : String -> Route -> Model -> ( Model, Cmd Msg )
showRouteRequiringIndividualSheetApi leagueTitle route model =
    if Dict.member leagueTitle model.leagues == False then
        refreshRouteRequiringIndividualSheetApi leagueTitle route model

    else
        ( { model | route = route }, Cmd.none )


refreshRouteRequiringIndividualSheetApi : String -> Route -> Model -> ( Model, Cmd Msg )
refreshRouteRequiringIndividualSheetApi leagueTitle route model =
    ( { model
        | leagues =
            Dict.insert
                leagueTitle
                RemoteData.Loading
                model.leagues
        , route = route
      }
    , fetchLeagueGames leagueTitle model.config
    )


fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    fetchIndividualSheet
        leagueTitle
        config
        (IndividualSheetResponse leagueTitle)


individualSheetResponse : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponse model response leagueTitle =
    ( { model
        | leagues =
            Dict.insert
                leagueTitle
                (RemoteData.map calculateLeague response)
                model.leagues
      }
    , Cmd.none
    )
