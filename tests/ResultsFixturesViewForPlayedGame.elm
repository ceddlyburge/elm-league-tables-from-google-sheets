module ResultsFixturesViewForPlayedGame exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Date exposing (..)
import Date.Extra exposing (..)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import ResultsFixturesHelpers exposing (..)


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
        , test "homeTeamGoals" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamGoals" ]
                |> Query.has [ Test.Html.Selector.text "1"]
        , test "awayTeamGoals" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamGoals" ]
                |> Query.has [ Test.Html.Selector.text "0"]
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
        , homeTeamGoals = Just 1
        , awayTeamName = "Meridian"
        , awayTeamGoals = Just 0 }
    |> Query.find [ Test.Html.Selector.class "data-test-day" ]
