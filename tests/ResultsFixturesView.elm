module ResultsFixturesView exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import RemoteData exposing (WebData)

import ResultsFixtures.View exposing (view)
import Models.Model exposing (vanillaModel)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)


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

onePlayedGameElement =
    gameElement { vanillaGame | homeTeamName = "Castle", homeTeamGoals = Just 1, awayTeamName = "Meridian", awayTeamGoals = Just 0 }

--teamElement : Query.Single Msg.Msg
gameElement game  =
    view "" (RemoteData.Success (LeagueGames "" [ game ]))  vanillaModel.device
        |> Query.fromHtml
        |> Query.find [ Test.Html.Selector.class "team" ]

vanillaGame : Game
vanillaGame = 
    Game "" Nothing "" Nothing "" "" "" "" "" "" 