import Spec exposing (..)

import SpreadsheetIdResponseDiv1Div2 exposing (..)
import Models.Model exposing ( Model, vanillaModel )
import Models.Config exposing ( Config )
import Update exposing (update)
import View exposing (view)

specs : Node
specs =
  describe "List of avaiable leagues"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponseDiv1Div2 }
            }
          ]
        ,it "displays available leagues"
        [ steps.click ".refresh"
          , assert.containsText
          { selector = ".leagues .league:first-Child"
          , text = "Regional Div 1"
          }
        , assert.containsText
          { selector = ".leagues .league:nth-Child(2)"
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
    , init = \_ -> { vanillaModel | config = Config "spreadSheetId" "googleApiKey" }
    } specs

