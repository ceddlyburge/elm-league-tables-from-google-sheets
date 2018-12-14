module Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)

calculateResultsFixtures: LeagueGames -> ResultsFixtures
calculateResultsFixtures leagueGames =
    ResultsFixtures 
        leagueGames.leagueTitle [ LeagueGamesForDay Nothing leagueGames.games ]

