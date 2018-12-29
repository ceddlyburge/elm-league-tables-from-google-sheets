module ResultsFixturesViewForUnplayedGameWithNoDate exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import ResultsFixturesHelpers exposing (..)


oneUnplayedGame : Test
oneUnplayedGame =
    describe "Displays one unplayed game correctly"
        [ 
        test "date" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-dayHeader" ]
                |> Query.has [ Test.Html.Selector.text "Unscheduled"]
        , test "homeTeamName" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Castle"]
        , test "awayTeamName" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Meridian"]
        ]
dayElement: Query.Single Msg
dayElement =
    html { vanillaGame | homeTeamName = "Castle", awayTeamName = "Meridian" }
    |> Query.find [ Test.Html.Selector.class "data-test-day" ]

