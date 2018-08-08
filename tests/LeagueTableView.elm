module LeagueTableView exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Html exposing (div, ul, li, text)
import Html.Attributes exposing (class)
import LeagueTable.View exposing (view)
import Models.Config exposing (Config)
import Models.Model exposing (Model)
import Models.Team exposing (Team)
import Models.LeagueTable exposing (LeagueTable)


-- also wants to show the league title


oneTeam : Test
oneTeam =
    describe "Displays one team correctly"
        [ 
        test "name" <|
            \_ ->
                teamElement
                |> Query.find [ Test.Html.Selector.class "name" ]
                |> Query.has [ Test.Html.Selector.text "Castle"]
        , test "points" <|
            \_ ->
                teamElement
                |> Query.find [ Test.Html.Selector.class "points" ]
                |> Query.has [ Test.Html.Selector.text "3"]
        , test "games played" <|
            \_ ->
                teamElement
                |> Query.find [ Test.Html.Selector.class "gamesPlayed" ]
                |> Query.has [ Test.Html.Selector.text "1"]
        , test "goals for" <|
            \_ ->
                teamElement
                |> Query.find [ Test.Html.Selector.class "goalsFor" ]
                |> Query.has [ Test.Html.Selector.text "6"]
        , test "goals against" <|
            \_ ->
                teamElement
                |> Query.find [ Test.Html.Selector.class "goalsAgainst" ]
                |> Query.has [ Test.Html.Selector.text "4"]
        , test "goal difference" <|
            \_ ->
                teamElement
                |> Query.find [ Test.Html.Selector.class "goalDifference" ]
                |> Query.has [ Test.Html.Selector.text "2"]
        ]

--teamElement : Query.Single Msg.Msg
teamElement  =
    view (modelWithTeams [ Team "Castle" 1 3 6 4 2 ])
        |> Query.fromHtml
        |> Query.find [ Test.Html.Selector.class "team" ]

modelWithTeams : List Team -> Model
modelWithTeams teams =
    Model (Config "" "") [] (LeagueTable "" teams)
