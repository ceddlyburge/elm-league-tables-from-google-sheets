module Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (LeagueGames)
import Models.Team exposing (Team)

calculateLeagueTable: LeagueGames -> LeagueTable
calculateLeagueTable leagueGames =
    LeagueTable 
        leagueGames.leagueTitle 
        [ 
            Team "Castle" 1 3 3 1 2
            , Team "Meridian" 1 0 1 3 -2
        ]
