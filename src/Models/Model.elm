module Models.Model exposing (..)

import RemoteData exposing (WebData)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.Config exposing (Config)
import Models.State as State exposing (State)
import Models.Route as Route exposing (Route)
import Element exposing (Device, classifyDevice)
import Window exposing (size)

type alias Model =
    { config: Config
    , state: State -- do we need this and route? probably not
    , route: Route
    , leagues: WebData (List LeagueSummary)
    , leagueTable: WebData (LeagueTable)
    , device: Device
    }

vanillaModel : Model
vanillaModel =
    Model 
        (Config "" "") 
        State.LeagueList 
        Route.NotFoundRoute 
        RemoteData.NotAsked 
        RemoteData.NotAsked 
        (classifyDevice <| Window.Size 1024 768)