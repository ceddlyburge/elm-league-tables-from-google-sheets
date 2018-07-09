module DecodeGoogleSheetToLeagueListTest exposing (..)

import Test exposing (..)
import Fuzz exposing (Fuzzer, list, string)
import Expect
import Json.Decode exposing (decodeString)
import Json.Encode exposing (encode, string)

import Models.League exposing (League)
import LeagueList.DecodeGoogleSheetToLeagueList exposing (decodeGoogleSheets)

decodeSpreadsheetIdResponse : Test
decodeSpreadsheetIdResponse  =
    fuzz (list Fuzz.string) "Sets League.Title from title property of google sheet / tab" <|
    \(leagueTitles) ->
        spreadsheetIdResponseWithSheetNames leagueTitles
        |> decodeString decodeGoogleSheets
        |> Expect.equal (Ok (List.map League leagueTitles))


-- This is a cut down response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE?key=<thekey>
spreadsheetIdResponseWithSheetNames: List String -> String
spreadsheetIdResponseWithSheetNames leagueTitles =
  """{
    "spreadsheetId": "blah",
    "properties": {
        "title": "Canoe Polo League Test Scores ",
        "locale": "etc"
    },
    "sheets": [
      """ ++ sheetsWithTitles leagueTitles ++ """
    ],
    "spreadsheetUrl": "blah"
  }"""

sheetsWithTitles: List String -> String
sheetsWithTitles leagueTitles =
    String.join "," (List.map sheetWithTitle leagueTitles)
  
sheetWithTitle: String -> String
sheetWithTitle title =
    """{
    "properties": {
        "sheetId": 1,
        "title":""" ++ encode 0 (Json.Encode.string title) ++ """,
        "etc": 0
    }
    }"""

