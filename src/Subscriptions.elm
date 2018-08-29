module Subscriptions exposing (subscriptions)

import Window exposing (resizes)
import Models.Model exposing (..)
import Msg exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Window.resizes SetScreenSize ]