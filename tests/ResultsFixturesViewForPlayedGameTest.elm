module ResultsFixturesViewForPlayedGameTest exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Date exposing (..)
import Date.Extra exposing (..)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import Models.Game exposing (vanillaGame)

onePlayedGame : Test
onePlayedGame =
    describe "Displays date, teams and score for played games"
        [ 
        test "date" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-dayHeader" ]
                |> Query.has [ Test.Html.Selector.text "March 23, 2006" ]
        , test "homeTeamName" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Castle"]
        , test "homeTeamGoalScorers" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamGoalScorers" ]
                |> Query.has [ Test.Html.Selector.text "Cedd, Lisa, Barry"]
        , test "homeTeamGoals" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamGoals" ]
                |> Query.has [ Test.Html.Selector.text "3"]
        , test "awayTeamGoalScorers" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamGoalScorers" ]
                |> Query.has [ Test.Html.Selector.text "Chad, Pog"]
        , test "awayTeamGoals" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamGoals" ]
                |> Query.has [ Test.Html.Selector.text "2"]
        , test "awayTeamName" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Meridian"]
        ]

dayElement: Query.Single Msg
dayElement =
    html { vanillaGame | 
        datePlayed = Just <| Date.Extra.fromCalendarDate 2006 Mar 23
        , homeTeamName = "Castle"
        , homeTeamGoals = Just 3
        , homeGoals = [ "Cedd" , "Lisa", "Barry" ]
        , awayTeamName = "Meridian"
        , awayGoals = [ "Chad", "Pog" ]
        , awayTeamGoals = Just 2 }
    |> Query.find [ Test.Html.Selector.class "data-test-day" ]
