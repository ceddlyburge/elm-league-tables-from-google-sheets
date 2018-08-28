module DecodeGoogleSheetToGameListTest exposing (..)

import Test exposing (..)
import Expect
import Json.Decode exposing (decodeString)
import Models.Game exposing (Game, LeagueGames)
import LeagueTable.DecodeGoogleSheetToGameList exposing (decodeSheetToLeagueGames)

-- I could probably fuzz test this by writing a custom fuzzer that created Game 's. 
-- The values from these could be used to create the json string, and to assert against.
-- Seems like a faff though, I might come back to it later.
decodeSpreadsheetIdResponse : Test
decodeSpreadsheetIdResponse =
    test "Sets League.Title from title property of google sheet / tab" <|
        \() ->
            spreadsheetValuesResponse 
                |> decodeString (decodeSheetToLeagueGames "Regional Div 1")
                |> Expect.equal (Ok (LeagueGames "Regional Div 1" [Game "Castle" (Just 3) "Meridian" (Just 1) "2018-06-04" "1, 6, 4" "2" "Green 3, Yellow 5" "Red 14" "good game" ]))

decodeInvalidSpreadsheetIdResponse : Test
decodeInvalidSpreadsheetIdResponse =
    test "Decoding fails if any games are invalid (as opposed to returning just the games that could be decoded)" <|
        \() ->
            invalidSpreadsheetValuesResponse 
                |> decodeString (decodeSheetToLeagueGames "doesnt matter")
                |> isError
                |> Expect.equal True 


isError : Result error value -> Bool
isError result =
  case result of
    Err error -> True    
    Ok value -> False

-- This is a cut down response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>
spreadsheetValuesResponse : String
spreadsheetValuesResponse =
    spreadsheetValuesHeader ++
    """
    [
      "Castle",
      "3",
      "1",
      "Meridian",
      "2018-06-04",
      "1, 6, 4",
      "2",
      "Green 3, Yellow 5",
      "Red 14",
      "good game"
    ]
    """
    ++ spreadsheetValuesFooter

-- this has one less item in the array than is required
invalidSpreadsheetValuesResponse : String
invalidSpreadsheetValuesResponse =
  spreadsheetValuesHeader ++
  """
  [
    "Castle",
    "0",
    "1",
    "Meridian",
    "2018-06-04",
    "1, 6, 4",
    "2",
    "Green 3, Yellow 5",
    "Red 14"
  ]
  """
  ++ spreadsheetValuesFooter

spreadsheetValuesHeader : String
spreadsheetValuesHeader =
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
    ],"""

spreadsheetValuesFooter : String
spreadsheetValuesFooter =
  """]
  }
  """
