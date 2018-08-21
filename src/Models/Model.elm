module Models.Model exposing (..)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.Config exposing (Config)
import Models.State exposing (State)
import Models.Route exposing (..)

type alias Model =
    { config: Config
    , state: State -- do we need this and route? probably not
    , route: Route
    , leagues: List LeagueSummary
    , leagueTable : LeagueTable
    }

vanillaModel : Model
vanillaModel =
    Model (Config "" "") Models.State.LeagueList NotFoundRoute [] ( LeagueTable "" [])