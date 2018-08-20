module Msg exposing (..)

import Http
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Game exposing (LeagueGames)
import Navigation exposing (Location)


type Msg
    = 
    -- league List
    AllSheetSummaryRequest
    | AllSheetSummaryResponse (Result Http.Error (List LeagueSummary))
    -- LeagueTable
    | IndividualSheetRequest String
    | IndividualSheetResponse (Result Http.Error LeagueGames)
    -- routing
    | OnLocationChange Location
    -- 
    | NoOp
