module Subscriptions exposing (subscriptions)

import Models.Model exposing (..)
import Msg exposing (..)
import Window exposing (resizes)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Window.resizes SetScreenSize ]
