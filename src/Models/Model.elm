module Models.Model exposing (Model, ModelAndKey, updateScreenSize, vanillaModel, vanillaModelAndKey)

import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import Element exposing (Device, classifyDevice)
import Models.Config exposing (Config, vanillaConfig)
import Models.League exposing (League)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)
import RemoteData exposing (WebData)



-- The business with the Key is really stupid, see
-- https://github.com/elm-explorations/test/issues/24


type alias ModelAndKey =
    { key : Key
    , model : Model
    }


type alias Model =
    { config : Config
    , route : Route
    , leagueSummaries : WebData (List LeagueSummary)
    , leagues : Dict String (WebData League)
    , device : Device
    , viewportWidth : Int
    , viewportHeight : Int
    }


updateScreenSize : Int -> Int -> Model -> Model
updateScreenSize width height model =
    { model
        | device = classifyDevice { width = width, height = height }
        , viewportWidth = width
        , viewportHeight = height
    }


vanillaModel : Model
vanillaModel =
    Model
        vanillaConfig
        Route.NotFound
        RemoteData.NotAsked
        Dict.empty
        (classifyDevice { width = 1024, height = 768 })
        1024
        768


vanillaModelAndKey : Key -> ModelAndKey
vanillaModelAndKey key =
    ModelAndKey key vanillaModel
