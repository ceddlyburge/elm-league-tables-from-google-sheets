module Messages.Msg exposing (..)

import Http

import Models.League exposing (League)

type Msg
    = SheetResponse (Result Http.Error (List League))
    | SheetRequest
    | NoOp


