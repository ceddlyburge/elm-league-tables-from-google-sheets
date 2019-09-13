module LeagueTableViewTest exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import RemoteData exposing (WebData)

import Pages.LeagueTable.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.Team exposing (Team)
import Models.LeagueTable exposing (LeagueTable)
import Msg exposing (..)
import Pages.Responsive exposing (..)

oneTeam : Test
oneTeam =
    describe "Displays one team correctly"
        [ 
        test "resultsFixtures" <|
            \_ ->
                html
                |> Query.has [ class "data-test-results-fixtures" ]
        , test "position" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-position" ]
                |> Query.has [ text "1" ]
        , test "name" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-name" ]
                |> Query.has [ text "Castle" ]
        , test "won" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-won" ]
                |> Query.has [ text "1" ]
        , test "drawn" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-drawn" ]
                |> Query.has [ text "0" ]
        , test "lost" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-lost" ]
                |> Query.has [ text "0" ]
        , test "points" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-points" ]
                |> Query.has [ text "3"]
        , test "games played" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-gamesPlayed" ]
                |> Query.has [ text "1"]
        , test "goals for" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-goalsFor" ]
                |> Query.has [ text "6"]
        , test "goals against" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-goalsAgainst" ]
                |> Query.has [ text "4"]
        , test "goal difference" <|
            \_ ->
                teamElement
                |> Query.find [ class "data-test-goalDifference" ]
                |> Query.has [ text "2"]
        ]

teamElement : Query.Single Msg.Msg
teamElement  =
    html
    |> Query.find [ Test.Html.Selector.class "data-test-team" ]

html : Query.Single Msg.Msg
html  =
    renderPage 
        vanillaResponsive
        (page "" (RemoteData.Success (LeagueTable "" [ Team 1 "Castle" 1 1 0 0 3 6 4 2 ]))  vanillaResponsive False)
    |> Query.fromHtml
