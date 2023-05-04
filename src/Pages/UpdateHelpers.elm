module Pages.UpdateHelpers exposing
    ( individualSheetResponse
    , refreshRouteRequiringIndividualSheetApi
    , showRouteRequiringIndividualSheetApi
    )

import Calculations.LeagueFromLeagueGames exposing (calculateLeague)
import Dict
import GoogleSheet.Api exposing (fetchIndividualSheet)
import Models.Config exposing (Config)
import Models.LeagueGames exposing (LeagueGames)
import Models.Model exposing (Model)
import Models.Route exposing (Route)
import Msg exposing (Msg(..))
import RemoteData exposing (RemoteData(..), WebData)


shouldRefreshModel : String -> Model -> Bool
shouldRefreshModel leagueTitle model =
    let
        shouldRefresh : RemoteData a b -> Bool
        shouldRefresh rmData =
            case rmData of
                NotAsked ->
                    True

                Loading ->
                    False

                Failure _ ->
                    True

                Success _ ->
                    False
    in
    case Dict.get leagueTitle model.leagues of
        Just dictElement ->
            shouldRefresh dictElement

        Nothing ->
            True


showRouteRequiringIndividualSheetApi : String -> Route -> Model -> ( Model, Cmd Msg )
showRouteRequiringIndividualSheetApi leagueTitle route model =
    if shouldRefreshModel leagueTitle model then
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
