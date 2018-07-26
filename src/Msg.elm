module Msg exposing (..)

import Http
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Game exposing (LeagueGames)


type Msg
    = 
    -- league List
    SheetRequest
    | SheetResponse (Result Http.Error (List LeagueSummary))
    -- LeagueTable
    | IndividualSheetRequest String
    | IndividualSheetResponse (Result Http.Error LeagueGames)
    -- 
    | NoOp
