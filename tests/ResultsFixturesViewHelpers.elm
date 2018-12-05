module ResultsFixturesViewHelpers exposing (..)

import Test.Html.Query as Query
import RemoteData exposing (WebData)

import Pages.ResultsFixtures.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.Model exposing (vanillaModel)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Msg exposing (..)

html :  Game -> Query.Single Msg
html game  =
    renderPage 
        vanillaModel.device
        (page "" (RemoteData.Success (LeagueGames "" [ game ]))  vanillaModel.device)
    |> Query.fromHtml
