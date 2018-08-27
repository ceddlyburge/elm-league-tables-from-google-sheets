module Msg exposing (..)

import RemoteData exposing (WebData)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.Game exposing (LeagueGames)
import Navigation exposing (Location)


type Msg
    = 
    -- league List
    AllSheetSummaryRequest
    | AllSheetSummaryResponse (WebData (List LeagueSummary))
    -- LeagueTable
    | IndividualSheetRequest String
    | IndividualSheetResponse String (WebData LeagueGames)
    -- routing
    | OnLocationChange Location
    -- 
    | NoOp
