module ResultsFixtures.Update exposing (individualSheetRequestForResultsFixtures, individualSheetResponseForResultsFixtures)

import Http
import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import LeagueTable.DecodeGoogleSheetToGameList exposing (..)
import Routing exposing (toUrl)

individualSheetRequestForResultsFixtures : String -> Model -> ( Model, Cmd Msg )
individualSheetRequestForResultsFixtures leagueTitle model  =
    ( { model | leagueTable = RemoteData.Loading }, fetchLeagueGames leagueTitle model.config )

individualSheetResponseForResultsFixtures : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponseForResultsFixtures  model response leagueTitle =
    ( 
        { model | 
            route = Route.ResultsFixturesRoute leagueTitle
            , leagueGames = response 
        }
        , newUrl <| toUrl <| Route.LeagueTableRoute leagueTitle
    )

fetchLeagueGames : String -> Config -> Cmd Msg
fetchLeagueGames leagueTitle config =
    Http.get 
        ("https://sheets.googleapis.com/v4/spreadsheets/" ++ 
            config.googleSheet ++ 
            "/values/" ++ 
            leagueTitle ++ 
            "?key=" ++ 
            config.googleApiKey) 
        (decodeSheetToLeagueGames leagueTitle)
        |> RemoteData.sendRequest
        |> Cmd.map (IndividualSheetResponse leagueTitle)
