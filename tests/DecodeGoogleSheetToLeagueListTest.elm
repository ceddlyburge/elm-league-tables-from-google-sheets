module DecodeGoogleSheetToLeagueListTest exposing (..)

import Test exposing (..)
import Expect
import Json.Decode exposing (decodeString)

import Models.League exposing (League)
import Updates.DecodeGoogleSheetToLeagueList exposing (decodeGoogleSheets)

-- use the api response we already have, might want to move it somewhere so it can be more easily shared between end to end tests and unit tests

decodeSpreadsheetIdResponse : Test
decodeSpreadsheetIdResponse  =
    test "Sets League.Title from title property of google sheet / tab" <|
    \() ->
        decodeString decodeGoogleSheets spreadsheetIdResponse
        |> Expect.equal (Ok ([ (League "Regional Div 1"), (League "Regional Div 2") ]))

-- decodeSpreadsheetIdResponse2 : Test
-- decodeSpreadsheetIdResponse2  =
--     fuzz List string "2 Sets League.Title from title property of google sheet / tab" <|
--     \() ->
--         decodeString decodeGoogleSheets spreadsheetIdResponse
--         |> Expect.equal (Ok ([ (League "Regional Div 1"), (League "Regional Div 2") ]))


sheetWithTitle: String -> String
sheetWithTitle title =
    """{
    "properties": {
        "sheetId": 1,
        "title":\"""" ++ title ++ """\",
        "etc": 0
    }
    }"""

-- This is a cut down response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE?key=<thekey>
spreadsheetIdResponse: String
spreadsheetIdResponse =
  """{
    "spreadsheetId": "blah",
    "properties": {
        "title": "Canoe Polo League Test Scores ",
        "locale": "etc"
    },
    "sheets": [
      """ ++ (sheetWithTitle "Regional Div 1") ++ """,
      """ ++ (sheetWithTitle "Regional Div 2") ++ """
    ],
    "spreadsheetUrl": "blah"
  }"""