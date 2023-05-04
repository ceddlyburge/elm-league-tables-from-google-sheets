module Models.ResultsFixtures exposing (ResultsFixtures)

import Models.LeagueGamesForDay exposing (LeagueGamesForDay)


type alias ResultsFixtures =
    { leagueTitle : String
    , days : List LeagueGamesForDay
    }
