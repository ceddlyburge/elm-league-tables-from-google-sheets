module LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)

import Http
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (LeagueGames)
import Models.Team exposing (Team)
import Models.Config exposing (Config)
import LeagueTable.DecodeGoogleSheetToGameList exposing (..)

individualSheetRequest : String -> Model -> ( Model, Cmd Msg )
individualSheetRequest leagueTitle model  =
    ( model, Http.send IndividualSheetResponse (request model.config leagueTitle) )

individualSheetResponse : LeagueGames -> Model -> ( Model, Cmd Msg )
individualSheetResponse leagueGames model =
    ( { model | leagueTable = calculateLeagueTable leagueGames }, Cmd.none ) 

calculateLeagueTable: LeagueGames -> LeagueTable
calculateLeagueTable leagueGames =
    LeagueTable 
        leagueGames.leagueTitle 
        [ 
            Team "Castle" 1 3 3 1 2
            , Team "Meridian" 1 0 1 3 -2
        ]

request : Config -> String -> Http.Request LeagueGames
request config leagueTitle =
    Http.get 
        ("https://sheets.googleapis.com/v4/spreadsheets/" ++ 
            config.googleSheet ++ 
            "spreadsheetId/values/" ++ 
            leagueTitle ++ 
            "?key=" ++ 
            config.googleApiKey) 
        (decodeSheetToLeagueGames leagueTitle)
