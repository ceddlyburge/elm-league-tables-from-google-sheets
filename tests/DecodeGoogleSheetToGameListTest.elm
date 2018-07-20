module DecodeGoogleSheetToGameListTest exposing (..)

import Test exposing (..)
import Fuzz exposing (Fuzzer, list, string)
import Expect
import Json.Decode exposing (decodeString)
import Json.Encode exposing (encode, string)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Game exposing (Game)
import LeagueTable.DecodeGoogleSheetToGameList exposing (decodeSheetToGames)


decodeSpreadsheetIdResponse : Test
decodeSpreadsheetIdResponse =
    test "Sets League.Title from title property of google sheet / tab" <|
        \() ->
            spreadsheetValuesResponse 
                |> decodeString decodeSheetToGames
                |> Expect.equal (Ok [Game "Castle" 3 "Meridian" 1 "2018-06-04" "1, 6, 4" "2" "good game" ])

-- This is a cut down response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>


spreadsheetValuesResponse : String
spreadsheetValuesResponse =
    """{
  "range": "'Regional Div 1'!A1:Z1000",
  "majorDimension": "ROWS",
  "values": [
    [
      "Home Team",
      "Home Score",
      "Away Score",
      "Away Team",
      "Date Played",
      "Home Scorers",
      "Away Scorers",
      "Home Cards",
      "Away Cards",
      "Notes"
    ],
    [
      "Castle",
      "3",
      "1",
      "Meridian",
      "2018-06-04",
      "1, 6, 4",
      "2",
      "good game"
    ]
  ]
}
"""


