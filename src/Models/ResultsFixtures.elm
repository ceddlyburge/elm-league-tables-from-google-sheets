module Models.ResultsFixtures exposing (ResultsFixtures, vanillaResultsFixtures)

import Models.LeagueGamesForDay exposing (LeagueGamesForDay)


type alias ResultsFixtures =
    { leagueTitle : String
    , days : List LeagueGamesForDay
    }

vanillaResultsFixtures : ResultsFixtures
vanillaResultsFixtures = 
    ResultsFixtures 
        ""
        [ 
            LeagueGamesForDay Nothing []
        ]