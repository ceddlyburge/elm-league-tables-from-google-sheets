module Models.Model exposing (..)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.Config exposing (Config)
import Models.State exposing (State)

type alias Model =
    { config: Config
    , state: State
    , leagues: List LeagueSummary
    , leagueTable : LeagueTable
    }

vanillaModel : Model
vanillaModel =
    Model (Config "" "") Models.State.LeagueList [] ( LeagueTable "" [])