module LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)

import Http
import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Game exposing (LeagueGames)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import LeagueTable.DecodeGoogleSheetToGameList exposing (..)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Routing exposing (toUrl)

individualSheetRequest : String -> Model -> ( Model, Cmd Msg )
individualSheetRequest leagueTitle model  =
    ( { model | leagueTable = RemoteData.Loading }, fetchLeagueGames leagueTitle model.config )

individualSheetResponse : Model -> WebData LeagueGames -> String -> ( Model, Cmd Msg )
individualSheetResponse  model response leagueTitle =
    ( 
        { model | 
            route = Route.LeagueTableRoute leagueTitle
            , leagueTable = RemoteData.map calculateLeagueTable response 
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
