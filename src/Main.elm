module Main exposing (..)

import Models.Config exposing (Config)
import Models.Model exposing (Model, vanillaModel)
import Msg exposing (Msg)
--import Navigation exposing (Location)
import Subscriptions
import Task exposing (perform)
import Update exposing (update)
import View exposing (view)
import Browser exposing (..)
--import Window exposing (size)


init : Config -> Location -> ( Model, Cmd Msg )
init config location =
    let
        ( model, cmd ) =
            update
                (Msg.OnLocationChange location)
                { vanillaModel | config = config }
    in
    ( model, Cmd.batch [ cmd, Task.perform Msg.SetScreenSize Window.size ] )



---- PROGRAM ----


main : Program Config Model Msg
main =
    Browser.application Msg.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = Subscriptions.subscriptions
        }
