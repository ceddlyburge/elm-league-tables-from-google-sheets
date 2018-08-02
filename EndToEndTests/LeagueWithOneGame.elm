import Spec exposing (..)

import SpreadsheetIdResponseDiv1 exposing (..)
import SpreadsheetValuesResponse exposing (..)

import Models.Model exposing ( Model )
import Models.Config exposing ( Config )
import Models.LeagueTable exposing ( LeagueTable )

import Update exposing (update)
import LeagueList.View exposing (view)

specs : Node
specs =
  describe "League Table"
    [ 
      context "with HTTP mocks"
        [ http
          [ { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId?key=googleApiKey"
            , response = { status = 200, body = spreadsheetIdResponseDiv1 }
            },
            { method = "GET"
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadsheetId/values/Regional%20Div%201?key=googleApiKey"
            , response = { status = 200, body = spreadsheetValuesResponse }
            }
          ]
        
          ,it "calculates and displays league table"
          [ steps.click "div.leagues"
          , steps.click "div.league" -- only one league in the results
          , assert.containsText
            { selector = ".teams .team:first-Child"
            , text = "Castle"
            }
          , assert.containsText
            { selector = ".teams .played:first-Child"
            , text = "1"
            }
          , assert.containsText
            { selector = ".teams .points:first-Child"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .goalsFor:first-Child"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .goalsAgainst:first-Child"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .goalDifference:first-Child"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2)"
            , text = "Meridian"
            }
          , assert.containsText
            { selector = ".teams .played:nth-Child(2)"
            , text = "1"
            }
          , assert.containsText
            { selector = ".teams .points:nth-Child(2)"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .goalsFor:nth-Child(2)"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .goalsAgainst:nth-Child(2)"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .goalDifference:nth-Child(2)"
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
    , init = \_ -> (Model (Config "spreadSheetId" "googleApiKey") [] (LeagueTable "" []) )
    } specs
