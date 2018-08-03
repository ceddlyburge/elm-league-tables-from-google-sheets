module LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)

import Http
import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Game exposing (LeagueGames)
import Models.Config exposing (Config)
import LeagueTable.DecodeGoogleSheetToGameList exposing (..)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

individualSheetRequest : String -> Model -> ( Model, Cmd Msg )
individualSheetRequest leagueTitle model  =
    ( model, Http.send IndividualSheetResponse (request model.config leagueTitle) )

individualSheetResponse : LeagueGames -> Model -> ( Model, Cmd Msg )
individualSheetResponse leagueGames model =
    ( { model | leagueTable = calculateLeagueTable leagueGames }, Cmd.none ) 

request : Config -> String -> Http.Request LeagueGames
request config leagueTitle =
    Http.get 
        ("https://sheets.googleapis.com/v4/spreadsheets/" ++ 
            config.googleSheet ++ 
            "/values/" ++ 
            leagueTitle ++ 
            "?key=" ++ 
            config.googleApiKey) 
        (decodeSheetToLeagueGames leagueTitle)
