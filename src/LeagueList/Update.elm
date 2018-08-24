module LeagueList.Update exposing (allSheetSummaryRequest, allSheetSummaryResponse)

import Http
import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing (Config)
import Models.State as State exposing (State)
import Models.Route as Route exposing (Route)
import LeagueList.DecodeGoogleSheetToLeagueList exposing (..)
import Routing exposing (toUrl)


allSheetSummaryRequest : Model -> ( Model, Cmd Msg )
allSheetSummaryRequest model =
    ( { model | leagues = RemoteData.Loading }, fetchLeagueSummaries model.config )


request : Config -> Http.Request (List LeagueSummary)
request config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeAllSheetSummaryToLeagueSummaries

fetchLeagueSummaries : Config -> Cmd Msg
fetchLeagueSummaries config =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeAllSheetSummaryToLeagueSummaries
        |> RemoteData.sendRequest
        |> Cmd.map AllSheetSummaryResponse

allSheetSummaryResponse: Model -> WebData (List LeagueSummary) -> ( Model, Cmd Msg )
allSheetSummaryResponse model response = 
    ( { model | state = State.LeagueList, route = Route.LeagueListRoute, leagues = response }, newUrl <| toUrl Route.LeagueListRoute )
