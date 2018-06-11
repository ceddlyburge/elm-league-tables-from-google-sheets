import MainFunctions exposing(..)
import Spec exposing (..)
--import EndToEndTests.GoogleSheetApiResponses exposing (spreadsheetIdResponse)

specs : Node
specs =
  describe "LeagueTable"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponse
--               """{
--   "spreadsheetId": "1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE",
--   "properties": {
--     "title": "Canoe Polo League Test Scores ",
--     "locale": "en_US",
--     "autoRecalc": "ON_CHANGE",
--     "timeZone": "Europe/London",
--     "defaultFormat": {
--       "backgroundColor": {
--         "red": 1,
--         "green": 1,
--         "blue": 1
--       },
--       "padding": {
--         "top": 2,
--         "right": 3,
--         "bottom": 2,
--         "left": 3
--       },
--       "verticalAlignment": "BOTTOM",
--       "wrapStrategy": "OVERFLOW_CELL",
--       "textFormat": {
--         "foregroundColor": {},
--         "fontFamily": "arial,sans,sans-serif",
--         "fontSize": 10,
--         "bold": false,
--         "italic": false,
--         "strikethrough": false,
--         "underline": false
--       }
--     }
--   },
--   "sheets": [
--     {
--       "properties": {
--         "sheetId": 0,
--         "title": "Regional Div 2",
--         "index": 0,
--         "sheetType": "GRID",
--         "gridProperties": {
--           "rowCount": 1000,
--           "columnCount": 26
--         }
--       }
--     }
--   ],
--   "spreadsheetUrl": "https://docs.google.com/spreadsheets/d/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/edit"
-- }""" 
            }
          }
        ]
        ,it "displays available leagues"
        [ steps.click "div.leagues"
        , assert.containsText
          { selector = ".leagues .league"
          , text = "Regional Div 2"
          }
        ]
      ]
    ]

main =
  runWithProgram 
    { subscriptions = \_ -> Sub.none
    , update = update
    , view = view
    , init = \_ -> (Model (Config "spreadSheetId" "googleApiKey") [])
    } specs


spreadsheetIdResponse: String
spreadsheetIdResponse =
  """{
  "spreadsheetId": "1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE",
  "properties": {
    "title": "Canoe Polo League Test Scores ",
    "locale": "en_US",
    "autoRecalc": "ON_CHANGE",
    "timeZone": "Europe/London",
    "defaultFormat": {
      "backgroundColor": {
        "red": 1,
        "green": 1,
        "blue": 1
      },
      "padding": {
        "top": 2,
        "right": 3,
        "bottom": 2,
        "left": 3
      },
      "verticalAlignment": "BOTTOM",
      "wrapStrategy": "OVERFLOW_CELL",
      "textFormat": {
        "foregroundColor": {},
        "fontFamily": "arial,sans,sans-serif",
        "fontSize": 10,
        "bold": false,
        "italic": false,
        "strikethrough": false,
        "underline": false
      }
    }
  },
  "sheets": [
    {
      "properties": {
        "sheetId": 0,
        "title": "Regional Div 2",
        "index": 0,
        "sheetType": "GRID",
        "gridProperties": {
          "rowCount": 1000,
          "columnCount": 26
        }
      }
    }
  ],
  "spreadsheetUrl": "https://docs.google.com/spreadsheets/d/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/edit"
}"""