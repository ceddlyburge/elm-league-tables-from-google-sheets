module GoogleSheet.Api exposing (fetchLeagueSummaries)

import Http
import RemoteData exposing (WebData)

import Models.Config exposing (Config)
import Models.LeagueSummary exposing (LeagueSummary)
import GoogleSheet.DecodeGoogleSheetToLeagueList exposing (decodeAllSheetSummaryToLeagueSummaries)

fetchLeagueSummaries : Config -> ((WebData (List LeagueSummary)) -> msg) -> Cmd msg
fetchLeagueSummaries config msg =
    Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeAllSheetSummaryToLeagueSummaries
        |> RemoteData.sendRequest
        |> Cmd.map msg