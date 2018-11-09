import Spec exposing (..)

import SpreadsheetIdResponses exposing (..)
import SpreadsheetValuesResponse exposing (..)

import Models.Model exposing ( Model, vanillaModel )
import Models.Config exposing ( Config )

import Update exposing (update)
import View exposing (view)

specs : Node
specs =
  describe "League Table With One Game"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponseDiv1 }
            },
            { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId/values/Regional Div 1?key=googleApiKey"
            , response = { status = 200, body = spreadsheetValuesResponse }
            }
          ]
        
          ,it "calculates and displays league table"
          [ steps.click ".refresh"
          , steps.click ".league" -- only one league in the results
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .name"
            , text = "Castle"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .gamesPlayed"
            , text = "1"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .points"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .goalsFor"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .goalsAgainst"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .goalDifference"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(3) .name"
            , text = "Meridian"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(3) .gamesPlayed"
            , text = "1"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(3) .points"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(3) .goalsFor"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(3) .goalsAgainst"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(3) .goalDifference"
            , text = "-3"
            }
          ]
        ]
      ]

main =
  runWithProgram 
    { subscriptions = \_ -> Sub.none
    , update = update
    , view = view
    ,init = \_ -> { vanillaModel | config = Config "spreadSheetId" "googleApiKey" }
    } specs
