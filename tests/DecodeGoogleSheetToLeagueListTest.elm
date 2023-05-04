module DecodeGoogleSheetToLeagueListTest exposing (decodeSpreadsheetIdResponse)

import Expect
import Fuzz exposing (list)
import GoogleSheet.DecodeGoogleSheetToLeagueList exposing (decodeAllSheetSummaryToLeagueSummaries)
import Json.Decode exposing (decodeString)
import Json.Encode exposing (encode)
import Models.LeagueSummary exposing (LeagueSummary)
import Test exposing (..)


decodeSpreadsheetIdResponse : Test
decodeSpreadsheetIdResponse =
    fuzz (list Fuzz.string) "Sets League.Title from title property of google sheet / tab" <|
        \leagueTitles ->
            spreadsheetIdResponseWithSheetTitles leagueTitles
                |> decodeString decodeAllSheetSummaryToLeagueSummaries
                |> Expect.equal (Ok (List.map LeagueSummary leagueTitles))



-- This is a cut down response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE?key=<thekey>


spreadsheetIdResponseWithSheetTitles : List String -> String
spreadsheetIdResponseWithSheetTitles titles =
    """{
    "spreadsheetId": "not used",
    "properties": {
        "title": "not used",
        "locale": "not used"
    },
    "sheets": [
      """ ++ sheetsWithTitles titles ++ """
    ],
    "spreadsheetUrl": "not used"
  }"""


sheetsWithTitles : List String -> String
sheetsWithTitles titles =
    String.join "," (List.map sheetWithTitle titles)


sheetWithTitle : String -> String
sheetWithTitle title =
    """{
    "properties": {
        "sheetId": 1,
        "title":""" ++ encode 0 (Json.Encode.string title) ++ """,
        "etc": 0
    }
    }"""
