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
    --Http.get ("https://sheets.googleapis.com/v4/spreadsheets/" ++ config.googleSheet ++ "?key=" ++ config.googleApiKey) decodeAllSheetSummaryToLeagueSummaries
    Http.request 
    { method = "GET"
    , headers = 
        [ Http.header "Content-type" "application/json"
        , Http.header "Accept" "application/json"
        ]
    , url = "/.netlify/functions/google-api"
    , body = Http.emptyBody
    , expect = Http.expectJson decodeAllSheetSummaryToLeagueSummaries
    , timeout = Nothing
    , withCredentials = False
    }
    |> RemoteData.sendRequest
    |> Cmd.map msg

fetchIndividualSheet : String -> Config -> ((WebData LeagueGames) -> msg) -> Cmd msg
fetchIndividualSheet leagueTitle config msg =
    --get : String -> Decode.Decoder a -> Request a
    --   request
    -- { method = "GET"
    -- , headers = []
    -- , url = url
    -- , body = emptyBody
    -- , expect = expectJson decoder
    -- , timeout = Nothing
    -- , withCredentials = False
    -- }


    Http.request 
    { method = "GET"
    , headers = 
        [ Http.header "Content-type" "application/json"
        , Http.header "Accept" "application/json"
        ]
    , url = "/.netlify/functions/google-api?leagueTitle=" ++ leagueTitle
    , body = Http.emptyBody
    , expect = Http.expectJson (decodeSheetToLeagueGames leagueTitle)
    , timeout = Nothing
    , withCredentials = False
    }
        -- ("/.netlify/functions/google-api?leagueTitle=" 
        -- ++ leagueTitle)
        -- (decodeSheetToLeagueGames leagueTitle)
    |> RemoteData.sendRequest
    |> Cmd.map msg
