module Models.Model exposing (..)

import Dict exposing (Dict)
import RemoteData exposing (WebData)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.Player as Player exposing (Player)
import Models.Config exposing (Config, vanillaConfig)
import Models.Route as Route exposing (Route)
import Element exposing (Device, classifyDevice)
import Window exposing (size)

type alias Model =
    { config: Config
    , route: Route
    , leagues: WebData (List LeagueSummary)
    , leagueTables: Dict String (WebData LeagueTable)
    , resultsFixtures: Dict String (WebData ResultsFixtures)
    , players: Dict String (WebData Player)
    , device: Device
    }

vanillaModel : Model
vanillaModel =
    Model 
        vanillaConfig 
        Route.NotFound 
        RemoteData.NotAsked 
        Dict.empty
        Dict.empty
        Dict.empty
        (classifyDevice <| Window.Size 1024 768)