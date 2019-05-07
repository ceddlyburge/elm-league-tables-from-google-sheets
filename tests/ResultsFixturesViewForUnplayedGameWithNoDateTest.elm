module ResultsFixturesViewForUnplayedGameWithNoDateTest  exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import TestHelpers exposing (..)


oneUnplayedGame : Test
oneUnplayedGame =
    describe "Displays 'Unscheduled' and team names for unplayed games with no date"
        [ 
        test "date" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-dayHeader" ]
                |> Query.has [ Test.Html.Selector.text "Unscheduled"]
        , test "time" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-datePlayed" ]
                |> Query.has [ Test.Html.Selector.text ""]
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

