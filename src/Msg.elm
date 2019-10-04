module Msg exposing (..)

import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueSummary exposing (LeagueSummary)
--import Navigation exposing (Location)
import Url exposing (Url)
import RemoteData exposing (WebData)
--import Window exposing (size)
import Browser.Events exposing (onResize)


type Msg
    = -- league List
      ShowLeagueList
    | RefreshLeagueList
    | AllSheetSummaryResponse (WebData (List LeagueSummary))
      -- Fixtures / Results, LeagueTable, TopScorers
    | ShowLeagueTable String
    | RefreshLeagueTable String
    | ShowResultsFixtures String
    | RefreshResultsFixtures String
    | ShowTopScorers String
    | RefreshTopScorers String
    | IndividualSheetResponse String (WebData LeagueGames)
      -- routing
    | OnLocationChange Url
      -- responsiveness
    | SetScreenSize onResize
      --
    | NoOp
