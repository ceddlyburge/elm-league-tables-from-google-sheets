module Msg exposing (..)

import RemoteData exposing (WebData)
import Window exposing (size)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueGames exposing (LeagueGames)
import Navigation exposing (Location)


type Msg
    = 
    -- league List
    ShowLeagueList
    | RefreshLeagueList
    | AllSheetSummaryResponse (WebData (List LeagueSummary))
    -- LeagueTable
    | IndividualSheetRequest String
    | IndividualSheetResponse String (WebData LeagueGames)
    -- Fixtures / Results
    | IndividualSheetRequestForResultsFixtures String
    | IndividualSheetResponseForResultsFixtures String (WebData LeagueGames)
    -- routing
    | OnLocationChange Location
    -- responsiveness
    | SetScreenSize Window.Size
    -- 
    | NoOp
