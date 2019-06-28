module GoogleSheet.Api exposing (fetchLeagueSummaries, fetchIndividualSheet)

import Http
import RemoteData exposing (WebData)

import Models.Config exposing (Config)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueGames exposing (LeagueGames)
import GoogleSheet.DecodeGoogleSheetToLeagueList exposing (..)
import GoogleSheet.DecodeGoogleSheetToGameList exposing (..)

fetchLeagueSummaries : Config -> ((WebData (List LeagueSummary)) -> msg) -> Cmd msg
fetchLeagueSummaries config msg =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeAllSheetSummaryToLeagueSummaries
    |> RemoteData.sendRequest
    |> Cmd.map msg

fetchIndividualSheet : String -> Config -> ((WebData LeagueGames) -> msg) -> Cmd msg
fetchIndividualSheet leagueTitle config msg =
    Http.get 
        --("https://sheets.googleapis.com/v4/spreadsheets/" ++ 
        ("http://localhost:9000/.netlify/functions/google-api?leagueTitle=" 
        ++ leagueTitle)
        --  ++
        --     config.googleSheet ++ 
        --     "/values/" ++ 
        --     leagueTitle ++ 
        --     "?key=" ++ 
        --     config.googleApiKey) 
        (decodeSheetToLeagueGames leagueTitle)
    |> RemoteData.sendRequest
    |> Cmd.map msg


-- return fetch('/.netlify/functions/todos-create', {
--     body: JSON.stringify(data),
--     method: 'POST'
--   }).then(response => {
--     return response.json()
--   })