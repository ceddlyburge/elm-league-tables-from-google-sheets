module Models.Model exposing (..)

import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.Config exposing (Config)


type Model
    = LeagueList LeagueListModel
    | LeagueTable LeagueTableModel


type alias LeagueListModel =
    { config : Config
    , leagues : List LeagueSummary
    }


type alias LeagueTableModel =
    { config : Config
    , league : LeagueTable
    }



-- type alias Model =
--     { config: Config,
--     leagues: List LeagueSummary,
--     current: List Team
--     }
