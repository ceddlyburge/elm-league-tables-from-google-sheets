module Main exposing (..)

import Html exposing (Html)
import MainFunctions exposing (..)

-- It is not possible to import this module in to an elm-spec test, as it tells me there is a circular dependency. 
-- There isn't one that I can see, so it must be created by the test runner or something like that.
-- The upshot is that any code in this file is defintely not covered by the "end to end" tests.
-- This is a bit of a shame, but its a good enough compromise I think.

init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


---- PROGRAM ----
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
