module ResultsFixturesViewHelpers exposing (..)

import Test.Html.Query as Query
import RemoteData exposing (WebData)

import Pages.ResultsFixtures.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Msg exposing (..)
import Pages.Progressive exposing (..)

html :  Game -> Query.Single Msg
html game  =
    renderPage 
        vanillaProgressive
        (page "" (RemoteData.Success (ResultsFixtures "" [ LeagueGamesForDay game.datePlayed [ game ] ]))  vanillaProgressive)
    |> Query.fromHtml
