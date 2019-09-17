module Calculations.LeagueFromLeagueGames exposing (calculateLeague)

import Models.LeagueGames exposing (LeagueGames)
import Models.League exposing (League)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Calculations.PlayersFromLeagueGames exposing (calculatePlayers)

calculateLeague: LeagueGames -> League
calculateLeague leagueGames = 
    League
        leagueGames.leagueTitle
        (calculateLeagueTable leagueGames)
        (calculateResultsFixtures leagueGames)
        (calculatePlayers leagueGames.games)