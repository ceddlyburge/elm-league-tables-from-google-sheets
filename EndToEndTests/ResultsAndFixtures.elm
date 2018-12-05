import Spec exposing (..)

import SpreadsheetIdResponses exposing (..)
import SpreadsheetValuesOneResultTwoFixturesResponse exposing (..)

import Models.Model exposing ( Model, vanillaModel )
import Models.Config exposing ( Config )

import Update exposing (update)
import View exposing (view)

specs : Node
specs =
  describe "Results and Fixtures"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponseDiv1 }
            },
            { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId/values/Regional Div 1?key=googleApiKey"
            , response = { status = 200, body = spreadsheetValuesOneResultTwoFixturesResponse }
            }
          ]
        
          ,it "shows results and fixtures"
          [ steps.click ".data-test-refresh"
          , steps.click ".data-test-league" -- only one league in the results
          , steps.click ".data-test-resultsAndFixtures" -- shows results and fixtures page
          , assert.containsText
            { selector = ".el"
            , text = "Castle"
            }
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(1) .data-test-homeTeamGoals"
            , text = "3"
            }
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(1) .data-test-awayTeamGoals"
            , text = "0"
            }          
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(1) .data-test-awayTeamName"
            , text = "Meridian"
            }
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(2) .data-test-homeTeamName"
            , text = "Battersea"
            }
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(2) .data-test-awayTeamName"
            , text = "Clapham"
            }
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(3) .data-test-homeTeamName"
            , text = "Blackwater"
            }
          , assert.containsText
            { selector = ".data-test-games .data-test-game:nth-Child(3) .data-test-awayTeamName"
            , text = "Nomad"
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
