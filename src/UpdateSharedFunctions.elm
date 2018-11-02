module UpdateSharedFunctions exposing (fetchIndividualSheet)

import Http
import RemoteData exposing (WebData)

import Models.LeagueGames exposing (LeagueGames)
import Models.Config exposing (Config)
import GoogleSheet.DecodeGoogleSheetToGameList exposing (..)

fetchIndividualSheet : String -> Config -> Cmd (WebData LeagueGames)
fetchIndividualSheet leagueTitle config =
    Http.get 
        ("https://sheets.googleapis.com/v4/spreadsheets/" ++ 
            config.googleSheet ++ 
            "/values/" ++ 
            leagueTitle ++ 
            "?key=" ++ 
            config.googleApiKey) 
        (decodeSheetToLeagueGames leagueTitle)
    |> RemoteData.sendRequest
