import MainFunctions exposing (..)
import Spec exposing (..)
import GoogleSheetApiResponses exposing (..)

specs : Node
specs =
  describe "LeagueTable"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponse
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
