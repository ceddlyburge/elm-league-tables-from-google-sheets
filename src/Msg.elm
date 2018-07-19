module Msg exposing (..)

import Http
import Models.LeagueSummary exposing (LeagueSummary)


type Msg
    = SheetResponse (Result Http.Error (List LeagueSummary))
    | SheetRequest
    | NoOp
