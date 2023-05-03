module LeagueTableViewTest exposing (..)

import Models.League exposing (League)
import Models.LeagueTable exposing (LeagueTable)
import Models.Player exposing (vanillaPlayers)
import Models.ResultsFixtures exposing (vanillaResultsFixtures)
import Models.Team exposing (Team)
import Msg exposing (..)
import Pages.LeagueTable.View exposing (..)
import Pages.RenderPage exposing (..)
import RemoteData exposing (WebData)
import Styles exposing (vanillaStyles)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, text)


oneTeam : Test
oneTeam =
    describe "Displays one team correctly"
        [ test "resultsFixtures" <|
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
                    |> Query.has [ text "3" ]
        , test "games played" <|
            \_ ->
                teamElement
                    |> Query.find [ class "data-test-gamesPlayed" ]
                    |> Query.has [ text "1" ]
        , test "goals for" <|
            \_ ->
                teamElement
                    |> Query.find [ class "data-test-goalsFor" ]
                    |> Query.has [ text "6" ]
        , test "goals against" <|
            \_ ->
                teamElement
                    |> Query.find [ class "data-test-goalsAgainst" ]
                    |> Query.has [ text "4" ]
        , test "goal difference" <|
            \_ ->
                teamElement
                    |> Query.find [ class "data-test-goalDifference" ]
                    |> Query.has [ text "2" ]
        ]


teamElement : Query.Single Msg.Msg
teamElement =
    html
        |> Query.find [ class "data-test-team" ]


html : Query.Single Msg.Msg
html =
    renderTestablePage
        vanillaStyles
        (page
            ""
            (RemoteData.Success
                (League
                    ""
                    (LeagueTable
                        ""
                        [ Team 1 "Castle" 1 1 0 0 3 6 4 2 ]
                    )
                    vanillaResultsFixtures
                    vanillaPlayers
                )
            )
            vanillaStyles
        )
        |> Query.fromHtml
