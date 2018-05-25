import MainFunctions exposing(..)
import Spec exposing (..)


specs : Node
specs =
  describe "LeagueTable"
    [ it "displays available leagues"
      [ assert.containsText
        { selector = ".leagues .league"
        , text = "Regional Div 2"
        }
      ]
    ]

-- main : Program Never (Spec.Runner.State Model Msg) (Spec.Runner.Msg Msg)
main =
  runWithProgram 
    { subscriptions = \_ -> Sub.none
    , update = update
    , view = view
    , init = \() -> Model
    } specs
