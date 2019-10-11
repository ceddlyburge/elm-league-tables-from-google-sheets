module Calculations.LeagueFromLeagueGames exposing (calculateLeague)

import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Calculations.PlayersFromLeagueGames exposing (calculatePlayers)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Models.League exposing (League)
import Models.LeagueGames exposing (LeagueGames)


calculateLeague : LeagueGames -> League
calculateLeague leagueGames =
    League
        leagueGames.leagueTitle
        (calculateLeagueTable leagueGames)
        (calculateResultsFixtures leagueGames)
        (calculatePlayers leagueGames.games)
