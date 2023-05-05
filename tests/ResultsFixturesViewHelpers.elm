module ResultsFixturesViewHelpers exposing (html)

import Helpers exposing (vanillaStyles)
import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Msg exposing (Msg)
import Pages.RenderPage exposing (renderTestablePage)
import Pages.ResultsFixtures.View exposing (page)
import RemoteData
import Test.Html.Query as Query


html : Game -> Query.Single Msg
html game =
    renderTestablePage
        vanillaStyles
        (page "" (RemoteData.Success (ResultsFixtures "" [ LeagueGamesForDay game.datePlayed [ game ] ])) vanillaStyles)
        |> Query.fromHtml
