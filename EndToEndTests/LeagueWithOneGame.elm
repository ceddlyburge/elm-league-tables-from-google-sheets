import Spec exposing (..)

import SpreadsheetIdResponseDiv1 exposing (..)
import SpreadsheetValuesResponse exposing (..)

import Models.Model exposing ( Model )
import Models.Config exposing ( Config )
import Models.LeagueTable exposing ( LeagueTable )

import Update exposing (update)
import View exposing (view)

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
            , url = "https://sheets.googleapis.com/v4/spreadsheets/spreadSheetId/values/Regional%20Div%201?key=googleApiKey"
            , response = { status = 200, body = spreadsheetValuesResponse }
            }
          ]
        
          ,it "calculates and displays league table"
          [ steps.click "h1.leaguesTitle"
          , steps.click "div.league" -- only one league in the results
          , assert.containsText
            { selector = ".teams .team:first-Child"
            , text = "Castle"
            }
          , assert.containsText
            { selector = ".teams .team:first-Child .gamesPlayed"
            , text = "1"
            }
          , assert.containsText
            { selector = ".teams .team:first-Child .points"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:first-Child .goalsFor"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:first-Child .goalsAgainst"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .team:first-Child .goalDifference"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2)"
            , text = "Meridian"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .gamesPlayed"
            , text = "1"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .points"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .goalsFor"
            , text = "0"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .goalsAgainst"
            , text = "3"
            }
          , assert.containsText
            { selector = ".teams .team:nth-Child(2) .goalDifference"
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
