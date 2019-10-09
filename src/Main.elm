module Main exposing (..)

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
        vanillaModelWithConfig = { vanillaModel | config = config }
        vanillaModelAndKeyWithConfig = { vanillamodelAndKey | model = vanillaModelWithConfig }
        ( model, cmd ) =
            update
                (Msg.OnLocationChange url)
                vanillaModelAndKeyWithConfig
    in
        --( model, Cmd.batch [ cmd, Task.perform Msg.SetScreenSize 1024 768 ] )
        ( model, cmd )



---- PROGRAM ----


main : Program Config ModelAndKey Msg
main =
    Browser.application 
        { init = init
        , view = view
        , update = update
        , subscriptions = Subscriptions.subscriptions
        , onUrlChange = Msg.OnLocationChange
        , onUrlRequest = Msg.OnUrlRequest
        }
