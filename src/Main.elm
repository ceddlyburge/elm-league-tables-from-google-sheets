module Main exposing (..)

import Element exposing (classifyDevice)
import Models.Config exposing (Config)
import Models.Model exposing (ModelAndKey, vanillaModelAndKey)
import Msg exposing (Msg)
import Subscriptions
import Task exposing (perform)
import Update exposing (update)
import View exposing (view)
import Browser exposing (..)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


init : Config -> Url -> Key -> ( ModelAndKey, Cmd Msg )
init config url key =
    let
        vanillamodelAndKey = vanillaModelAndKey key 
        vanillaModel = vanillamodelAndKey.model
        vanillaModelWithConfig = 
            { 
                vanillaModel | 
                    config = config
                    , device = (classifyDevice { width = config.windowWidth, height = config.windowHeight } ) 
            }
        vanillaModelAndKeyWithConfig = { vanillamodelAndKey | model = vanillaModelWithConfig }
        ( model, cmd ) =
            update
                (Msg.OnUrlChange url)
                vanillaModelAndKeyWithConfig
    in
        ( model, cmd )



---- PROGRAM ----


main : Program Config ModelAndKey Msg
main =
    Browser.application 
        { init = init
        , view = view
        , update = update
        , subscriptions = Subscriptions.subscriptions
        , onUrlChange = Msg.OnUrlChange
        , onUrlRequest = Msg.OnUrlRequest
        }
