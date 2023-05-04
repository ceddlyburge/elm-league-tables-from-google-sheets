module ResultsFixturesViewHelpers exposing (html)

import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Msg exposing (..)
import Pages.RenderPage exposing (..)
import Pages.ResultsFixtures.View exposing (..)
import RemoteData
import Styles exposing (vanillaStyles)
import Test.Html.Query as Query


html : Game -> Query.Single Msg
html game =
    renderTestablePage
        vanillaStyles
        (page "" (RemoteData.Success (ResultsFixtures "" [ LeagueGamesForDay game.datePlayed [ game ] ])) vanillaStyles)
        |> Query.fromHtml
