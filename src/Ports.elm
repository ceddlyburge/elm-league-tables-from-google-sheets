port module Ports exposing (..)

import Models.LeagueSummary exposing (LeagueSummary)
--import Models.LeagueGames exposing (LeagueGames)

port storeLeagues : List LeagueSummary -> Cmd msg
--port storeLeagueGames : LeagueGames -> Cmd msg