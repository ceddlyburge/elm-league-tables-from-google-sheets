module Models.Model exposing (..)

import Dict exposing (Dict)
import RemoteData exposing (WebData)

import Models.League exposing (League)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing (Config, vanillaConfig)
import Models.Route as Route exposing (Route)
import Element exposing (Device, classifyDevice)
import Window exposing (size)

type alias Model =
    { config: Config
    , route: Route
    , leagueSummaries: WebData (List LeagueSummary)
    , leagues: Dict String (WebData League)
    , device: Device
    }

vanillaModel : Model
vanillaModel =
    Model 
        vanillaConfig 
        Route.NotFound 
        RemoteData.NotAsked 
        Dict.empty
        (classifyDevice <| Window.Size 1024 768)