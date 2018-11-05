module Main exposing (..)

import Element exposing (classifyDevice)
import Window exposing (size)
import Task exposing (perform)

import Models.Config exposing (Config)
import Models.Model exposing (Model, vanillaModel)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Navigation exposing (Location)
import Subscriptions

-- It is not possible to import this module in to an elm-spec test, as it tells me there is a circular dependency.
-- There isn't one that I can see, so it must be created by the test runner or something like that.
-- The upshot is that any code in this file is defintely not covered by the "end to end" tests.
-- This is a bit of a shame, but its a good enough compromise I think.


init : Config -> Location -> ( Model, Cmd Msg )
init config location =
    let
        _ = Debug.log "href" location.href
        _ = Debug.log "host" location.host
        _ = Debug.log "hostname" location.hostname
        _ = Debug.log "protocol" location.protocol
        _ = Debug.log "origin" location.origin
        _ = Debug.log "port_" location.port_
        _ = Debug.log "pathnamee" location.pathname
        _ = Debug.log "search" location.search
        _ = Debug.log "hash" location.hash
        _ = Debug.log "username" location.username
        _ = Debug.log "password" location.password
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
