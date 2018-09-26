module LeagueTableView exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import RemoteData exposing (WebData)

import LeagueTable.View exposing (view)
import Models.Team exposing (Team)
import Models.LeagueTable exposing (LeagueTable)
import Models.Model exposing (vanillaModel)
import Msg exposing (..)

-- also wants to show the league title


oneTeam : Test
oneTeam =
    describe "Displays one team correctly"
        [ 
        test "resultsFixtures" <|
            \_ ->
                html
                |> Query.has [ class "resultsAndFixtures" ]
        , test "name" <|
            \_ ->
                teamElement
                |> Query.find [ class "name" ]
                |> Query.has [ text "Castle" ]
        , test "points" <|
            \_ ->
                teamElement
                |> Query.find [ class "points" ]
                |> Query.has [ text "3"]
        , test "games played" <|
            \_ ->
                teamElement
                |> Query.find [ class "gamesPlayed" ]
                |> Query.has [ text "1"]
        , test "goals for" <|
            \_ ->
                teamElement
                |> Query.find [ class "goalsFor" ]
                |> Query.has [ text "6"]
        , test "goals against" <|
            \_ ->
                teamElement
                |> Query.find [ class "goalsAgainst" ]
                |> Query.has [ text "4"]
        , test "goal difference" <|
            \_ ->
                teamElement
                |> Query.find [ class "goalDifference" ]
                |> Query.has [ text "2"]
        ]

teamElement : Query.Single Msg.Msg
teamElement  =
    html
    |> Query.find [ Test.Html.Selector.class "team" ]

html : Query.Single Msg.Msg
html  =
    view "" (RemoteData.Success (LeagueTable "" [ Team "Castle" 1 3 6 4 2 ]))  vanillaModel.device
    |> Query.fromHtml
