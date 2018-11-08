module ResultsFixturesViewHelpers exposing (..)

import Test.Html.Query as Query
import RemoteData exposing (WebData)

import Pages.ResultsFixtures.View exposing (view)
import Models.Model exposing (vanillaModel)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Msg exposing (..)

html :  Game -> Query.Single Msg
html game  =
    view "" (RemoteData.Success (LeagueGames "" [ game ]))  vanillaModel.device
        |> Query.fromHtml
