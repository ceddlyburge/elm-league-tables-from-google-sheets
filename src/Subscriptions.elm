module Subscriptions exposing (subscriptions)

import Models.Model exposing (..)
import Msg exposing (..)
import Browser.Events exposing (onResize)


subscriptions : ModelAndKey -> Sub Msg
subscriptions _ =
    onResize SetScreenSize
