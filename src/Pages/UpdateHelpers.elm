module Pages.UpdateHelpers exposing (
    individualSheetResponse
    , showRouteRequiringIndividualSheetApi
    , refreshRouteRequiringIndividualSheetApi
    )

import Dict exposing (Dict)
import RemoteData exposing (WebData)

import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import Msg exposing (..)
import GoogleSheet.Api exposing (fetchIndividualSheet)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Models.Route as Route exposing (Route)

showRouteRequiringIndividualSheetApi : String -> Route -> Model -> ( Model, Cmd Msg )
showRouteRequiringIndividualSheetApi leagueTitle route model =
    if (Dict.member leagueTitle model.leagueTables == False
        || Dict.member leagueTitle model.resultsFixtures == False)
    then  
        refreshRouteRequiringIndividualSheetApi leagueTitle route model
    else 
        ( { model | route = route }, Cmd.none )


refreshRouteRequiringIndividualSheetApi : String -> Route -> Model -> ( Model, Cmd Msg )
refreshRouteRequiringIndividualSheetApi leagueTitle route model =
    ( { model | 
            leagueTables = Dict.insert leagueTitle RemoteData.Loading model.leagueTables
            , resultsFixtures = Dict.insert leagueTitle RemoteData.Loading model.resultsFixtures
            , route = route 
    }
    , fetchLeagueGames leagueTitle model.config )

fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    fetchIndividualSheet 
        leagueTitle
        config 
        (IndividualSheetResponse leagueTitle)

individualSheetResponse : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponse  model response leagueTitle =
    ( 
        { model | 
            leagueTables = Dict.insert leagueTitle (RemoteData.map calculateLeagueTable response) model.leagueTables
            , resultsFixtures = Dict.insert leagueTitle (RemoteData.map calculateResultsFixtures response) model.resultsFixtures
        }
        , Cmd.none
    )
