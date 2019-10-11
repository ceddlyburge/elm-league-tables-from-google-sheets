module ResultsFixturesViewHelpers exposing (..)

import Test.Html.Query as Query
import RemoteData exposing (WebData)

import Pages.ResultsFixtures.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Msg exposing (..)
import Pages.Responsive exposing (..)

html :  Game -> Query.Single Msg
html game  =
    renderPage 
        vanillaResponsive
        (page "" (RemoteData.Success (ResultsFixtures "" [ LeagueGamesForDay game.datePlayed [ game ] ]))  vanillaResponsive)
    |> Query.fromHtml
