module Models.Model exposing (..)

import RemoteData exposing (WebData)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.LeagueGames exposing (LeagueGames)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import Element exposing (Device, classifyDevice)
import Window exposing (size)

type alias Model =
    { config: Config
    , route: Route
    , leagues: WebData (List LeagueSummary)
    , leagueTable: WebData (LeagueTable)
    , leagueGames: WebData (LeagueGames)
    , resultsFixtures: WebData (ResultsFixtures)
    , device: Device
    }

vanillaModel : Model
vanillaModel =
    Model 
        (Config "" "") 
        Route.NotFoundRoute 
        RemoteData.NotAsked 
        RemoteData.NotAsked 
        RemoteData.NotAsked 
        RemoteData.NotAsked 
        (classifyDevice <| Window.Size 1024 768)