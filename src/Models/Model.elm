module Models.Model exposing (..)

import Dict exposing (Dict)
import RemoteData exposing (WebData)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.Config exposing (Config)
import Models.Route as Route exposing (Route)
import Models.Animation as Animation exposing (Animation)
import Element exposing (Device, classifyDevice)
import Window exposing (size)

type alias Model =
    { config: Config
    , route: Route
    , leagues: WebData (List LeagueSummary)
    , leagueListAnimation : Animation
    , leagueTables: Dict String (WebData LeagueTable)
    , resultsFixtures: Dict String (WebData ResultsFixtures)
    , device: Device
    }

vanillaModel : Model
vanillaModel =
    Model 
        (Config "" "") 
        Route.NotFound 
        RemoteData.NotAsked
        Animation.Inactive 
        Dict.empty
        Dict.empty
        (classifyDevice <| Window.Size 1024 768)