module LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)

import Http
import Navigation exposing (newUrl)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.Game exposing (LeagueGames)
import Models.Config exposing (Config)
import Models.State as State exposing (State)
import Models.Route as Route exposing (Route)
import LeagueTable.DecodeGoogleSheetToGameList exposing (..)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Routing exposing (toUrl)

individualSheetRequest : String -> Model -> ( Model, Cmd Msg )
individualSheetRequest leagueTitle model  =
    ( { model | state = State.LeagueTable, route = Route.LeagueTableRoute leagueTitle }, Http.send IndividualSheetResponse (request model.config leagueTitle) )

individualSheetResponse : LeagueGames -> Model -> ( Model, Cmd Msg )
individualSheetResponse leagueGames model =
    ( { model | leagueTable = calculateLeagueTable leagueGames }, newUrl <| toUrl <| Route.LeagueTableRoute leagueGames.leagueTitle ) 

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
