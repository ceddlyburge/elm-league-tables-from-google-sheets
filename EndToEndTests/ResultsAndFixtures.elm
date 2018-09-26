import Spec exposing (..)

import SpreadsheetIdResponseDiv1 exposing (..)
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
          [ steps.click ".refresh"
          , steps.click ".league" -- only one league in the results
          , steps.click ".resultsAndFixtures" -- shows results and fixtures page
          , assert.containsText
            { selector = ".el"
            , text = "Castle"
            }
          , assert.containsText
            { selector = ".games .game:nth-Child(1) .homeTeamGoals"
            , text = "3"
            }
          , assert.containsText
            { selector = ".games .game:nth-Child(1) .awayTeamGoals"
            , text = "0"
            }          
          , assert.containsText
            { selector = ".games .game:nth-Child(1) .awayTeamName"
            , text = "Meridian"
            }
          , assert.containsText
            { selector = ".games .game:nth-Child(2) .homeTeamName"
            , text = "Battersea"
            }
          , assert.containsText
            { selector = ".games .game:nth-Child(2) .awayTeamName"
            , text = "Clapham"
            }
          , assert.containsText
            { selector = ".games .game:nth-Child(3) .homeTeamName"
            , text = "Blackwater"
            }
          , assert.containsText
            { selector = ".games .game:nth-Child(3) .awayTeamName"
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
