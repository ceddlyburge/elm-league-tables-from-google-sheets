module Models.Model exposing (..)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.Config exposing (Config)

type alias Model =
    { config: Config
    , leagues: List LeagueSummary
    , leagueTable : LeagueTable
    }
