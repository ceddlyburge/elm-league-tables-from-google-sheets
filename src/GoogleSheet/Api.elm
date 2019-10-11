module GoogleSheet.Api exposing (fetchIndividualSheet, fetchLeagueSummaries)

import GoogleSheet.DecodeGoogleSheetToGameList exposing (..)
import GoogleSheet.DecodeGoogleSheetToLeagueList exposing (..)
import Http
import Models.Config exposing (Config)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueSummary exposing (LeagueSummary)
import RemoteData exposing (WebData)


fetchLeagueSummaries : Config -> (WebData (List LeagueSummary) -> msg) -> Cmd msg
fetchLeagueSummaries config msg =
    Http.get (config.netlifyFunctionsServer ++ "/.netlify/functions/google-api") decodeAllSheetSummaryToLeagueSummaries
        |> RemoteData.sendRequest
        |> Cmd.map msg


fetchIndividualSheet : String -> Config -> (WebData LeagueGames -> msg) -> Cmd msg
fetchIndividualSheet leagueTitle config msg =
    Http.get
        (config.netlifyFunctionsServer ++ "/.netlify/functions/google-api?leagueTitle=" ++ leagueTitle)
        (decodeSheetToLeagueGames leagueTitle)
        |> RemoteData.sendRequest
        |> Cmd.map msg
