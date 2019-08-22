import Spec exposing (..)

import SpreadsheetIdResponses exposing (..)
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
            , url = "http://testhost/.netlify/functions/google-api"
            , response = { status = 200, body = spreadsheetIdResponseDiv1Div2 }
            }
          ]
        ,it "displays available leagues"
        [ steps.click ".data-test-refresh"
        , assert.containsText
          { selector = ".data-test-title"
          , text = "Test Title"
          }
        , assert.containsText
          { selector = ".data-test-leagues .data-test-league:first-Child"
          , text = "Regional Div 1"
          }
        , assert.containsText
          { selector = ".data-test-leagues .data-test-league:nth-Child(2)"
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
    , init = \_ -> { vanillaModel | config = Config "http://testhost" "Test Title" }
    } specs

