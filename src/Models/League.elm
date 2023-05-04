module Models.League exposing (League)

import Models.LeagueTable exposing (LeagueTable)
import Models.Player exposing (Players)
import Models.ResultsFixtures exposing (ResultsFixtures)


type alias League =
    { title : String
    , table : LeagueTable
    , resultsFixtures : ResultsFixtures
    , players : Players
    }
