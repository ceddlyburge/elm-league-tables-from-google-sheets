module Subscriptions exposing (subscriptions)

import Browser.Events exposing (onResize)
import Models.Model exposing (ModelAndKey)
import Msg exposing (Msg(..))


subscriptions : ModelAndKey -> Sub Msg
subscriptions _ =
    onResize SetScreenSize
