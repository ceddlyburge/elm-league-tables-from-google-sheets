module ResultsFixturesViewHelpers exposing (..)

import Test.Html.Query as Query
import RemoteData exposing (WebData)

import Pages.ResultsFixtures.View exposing (..)
import Pages.RenderPage exposing (..)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Msg exposing (..)
import Styles exposing (vanillaStyles)

html :  DecodedGame -> Query.Single Msg
html game  =
    renderTestablePage 
        vanillaStyles
        (page "" (RemoteData.Success (ResultsFixtures "" [ LeagueGamesForDay game.datePlayed [ game ] ]))  vanillaStyles)
    |> Query.fromHtml
