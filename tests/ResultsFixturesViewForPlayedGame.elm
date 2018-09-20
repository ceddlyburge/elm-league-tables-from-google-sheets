module ResultsFixturesViewForPlayedGame exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import ResultsFixturesHelpers exposing (..)


onePlayedGame : Test
onePlayedGame =
    describe "Displays one played game correctly"
        [ 
        test "homeTeamName" <|
            \_ ->
                onePlayedGameElement
                |> Query.find [ Test.Html.Selector.class "homeTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Castle"]
        , test "homeTeamGoals" <|
            \_ ->
                onePlayedGameElement
                |> Query.find [ Test.Html.Selector.class "homeTeamGoals" ]
                |> Query.has [ Test.Html.Selector.text "1"]
        , test "awayTeamGoals" <|
            \_ ->
                onePlayedGameElement
                |> Query.find [ Test.Html.Selector.class "awayTeamGoals" ]
                |> Query.has [ Test.Html.Selector.text "0"]
        , test "awayTeamName" <|
            \_ ->
                onePlayedGameElement
                |> Query.find [ Test.Html.Selector.class "awayTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Meridian"]
        ]

onePlayedGameElement: Query.Single Msg
onePlayedGameElement =
    html { vanillaGame | homeTeamName = "Castle", homeTeamGoals = Just 1, awayTeamName = "Meridian", awayTeamGoals = Just 0 }
    |> Query.find [ Test.Html.Selector.class "game" ]
