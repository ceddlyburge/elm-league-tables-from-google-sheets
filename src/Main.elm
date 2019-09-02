module Main exposing (..)

import Window exposing (size)
import Task exposing (perform)

import Models.Config exposing (Config)
import Models.Model exposing (Model, vanillaModel)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Navigation exposing (Location)
import Subscriptions


init : Config -> Location -> ( Model, Cmd Msg )
init config location =
    let
        (model, cmd) = 
            update 
            (Msg.OnLocationChange location)
            { vanillaModel | config = config }
    in
        (model, Cmd.batch [cmd, Task.perform Msg.SetScreenSize Window.size] )
     


---- PROGRAM ----


main : Program Config Model Msg
main =
    Navigation.programWithFlags Msg.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = Subscriptions.subscriptions
         }
