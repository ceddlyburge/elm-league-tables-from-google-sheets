module Calculations.TopScorersFromLeagueGames exposing (calculateTopScorers)

import Date exposing (..)
--import Date.Extra exposing (..)

--import List.Gather exposing (..)
import Models.LeagueGames exposing (LeagueGames)
import Models.Game exposing (Game)
--import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
--import Models.ResultsFixtures exposing (ResultsFixtures)

calculateResultsFixtures: LeagueGames -> ResultsFixtures
calculateResultsFixtures leagueGames =
    TopScorers 
        leagueGames.leagueTitle 
        (groupGamesByDate leagueGames.games
        |> List.map leagueGamesForDay
        |> List.sortWith daysDescendingDate)

