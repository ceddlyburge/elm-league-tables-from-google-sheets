module Pages.LeagueTable.Update exposing (individualSheetRequest, individualSheetResponse)

import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Routing exposing (toUrl)
import GoogleSheet.Api exposing (fetchIndividualSheet)

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
    fetchIndividualSheet 
        leagueTitle
        config 
        (IndividualSheetResponse leagueTitle)
