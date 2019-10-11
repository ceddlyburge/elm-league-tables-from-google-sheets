module Models.Model exposing (..)

import Dict exposing (Dict)
import Element exposing (Device, classifyDevice)
import Models.Config exposing (Config, vanillaConfig)
import Models.League exposing (League)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)
import RemoteData exposing (WebData)
import Browser.Events exposing (onResize)
import Browser.Navigation exposing (Key)


-- The business with the Key is really stupid, see
-- https://github.com/elm-explorations/test/issues/24
type alias ModelAndKey =
    { key: Key
    , model: Model
    }

type alias Model =
    { config : Config
    , route : Route
    , leagueSummaries : WebData (List LeagueSummary)
    , leagues : Dict String (WebData League)
    , device : Device
    }


vanillaModel : Model
vanillaModel =
    Model
        vanillaConfig
        Route.NotFound
        RemoteData.NotAsked
        Dict.empty
        (classifyDevice { width = 1024, height = 768 } )

vanillaModelAndKey : Key -> ModelAndKey
vanillaModelAndKey key =
    ModelAndKey key vanillaModel
