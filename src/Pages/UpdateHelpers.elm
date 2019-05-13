module Pages.UpdateHelpers exposing (individualSheetResponse, showRouteRequiringIndividualSheetApi)

import Dict exposing (Dict)
import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import Msg exposing (..)
import GoogleSheet.Api exposing (fetchIndividualSheet)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Routing exposing (toUrl)
import Models.Route as Route exposing (Route)

showRouteRequiringIndividualSheetApi : String -> Route -> Model -> ( Model, Cmd Msg )
showRouteRequiringIndividualSheetApi leagueTitle route model =
    if (Dict.member leagueTitle model.leagueTables == False
        || Dict.member leagueTitle model.resultsFixturess == False)
    then  
        ( { model | 
                leagueTables = Dict.insert leagueTitle RemoteData.Loading model.leagueTables
                , resultsFixturess = Dict.insert leagueTitle RemoteData.Loading model.resultsFixturess
                , route = route 
        }
        , fetchLeagueGames leagueTitle model.config )
    else 
        ( { model | route = route }, Cmd.none )


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
            , resultsFixturess = Dict.insert leagueTitle (RemoteData.map calculateResultsFixtures response) model.resultsFixturess
        }
        , newUrl <| toUrl <| model.route
    )
