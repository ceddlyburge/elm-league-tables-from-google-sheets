module Main exposing (..)

import Models.Config exposing (Config)
import Models.Model exposing (ModelAndKey, vanillaModel)
import Msg exposing (Msg)
import Subscriptions
import Task exposing (perform)
import Update exposing (update)
import View exposing (view)
import Browser exposing (..)


init : Config -> Url -> Key -> ( ModelAndKey, Cmd Msg )
init config location key =
    let
        ( model, cmd ) =
            update
                (Msg.OnLocationChange location)
                { vanillaModelAndKey key | config = config }
    in
    ( model, Cmd.batch [ cmd, Task.perform Msg.SetScreenSize Window.size ] )



---- PROGRAM ----


main : Program Config ModelAndKey Msg
main =
    Browser.application Msg.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = Subscriptions.subscriptions
        }
