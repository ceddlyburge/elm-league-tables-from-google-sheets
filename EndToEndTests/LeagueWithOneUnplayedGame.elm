import Spec exposing (..)

import SpreadsheetIdResponses exposing (..)
import SpreadsheetValuesWithOneUnplayedGameResponse exposing (..)

import Models.Model exposing ( Model, vanillaModel )
import Models.Config exposing ( Config )

import Update exposing (update)
import View exposing (view)

specs : Node
specs =
  describe "League Table With One Unplayed Game"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponseDiv1 }
            },
            { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId/values/Regional Div 1?key=googleApiKey"
            , response = { status = 200, body = spreadsheetValuesWithOneUnplayedGameResponse }
            }
          ]
        
          ,it "allows games in the future / games with no scores"
          [ steps.click ".data-test-refresh"
          , steps.click ".data-test-league" -- only one league in the results
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-position"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-name"
            , text = "Castle"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-gamesPlayed"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-won"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-drawn"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-lost"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-points"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-goalsFor"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-goalsAgainst"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(2) .data-test-goalDifference"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(3) .data-test-name"
            , text = "Meridian"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(3) .data-test-gamesPlayed"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(3) .data-test-points"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(3) .data-test-goalsFor"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(3) .data-test-goalsAgainst"
            , text = "0"
            }
          , assert.containsText
            { selector = ".data-test-teams .data-test-team:nth-Child(3) .data-test-goalDifference"
            , text = "0"
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
