module Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

import List.Extra exposing (unique)

import Calculations.SortBy exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Models.Team exposing (Team)

calculateLeagueTable: LeagueGames -> LeagueTable
calculateLeagueTable leagueGames =
    let
        homeTeams = List.map (\game -> game.homeTeamName) leagueGames.games
        awayTeams = List.map (\game -> game.awayTeamName) leagueGames.games
        teamNames = List.append homeTeams awayTeams |> unique
        goalsFor2 = List.map (goalsFor leagueGames.games) teamNames
        goalsAgainst2 = List.map (goalsAgainst leagueGames.games) teamNames
        gamesPlayed2 = List.map (gamesPlayed leagueGames.games) teamNames
        points2 = List.map (points leagueGames.games) teamNames
        teams = List.map (team leagueGames.games) teamNames
        sortedTeams = List.sortWith (by .points DESC |> andThen .goalDifference DESC |> andThen .goalsFor DESC) teams

    in
        LeagueTable 
            leagueGames.leagueTitle sortedTeams

team: List Game -> String -> Team
team games teamName =
    Team teamName  (gamesPlayed games teamName) (points games teamName) (goalsFor games teamName) (goalsAgainst games teamName) ((goalsFor games teamName) - (goalsAgainst games teamName))
    

points: List Game -> String -> Int
points games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gamePoints teamName game) games)

gamePoints: String -> Game -> Int
gamePoints teamName game =
    if teamName == game.homeTeamName then
        homePoints game
    else if teamName == game.awayTeamName then
        awayPoints game
    else    
        0

homePoints: Game -> Int
homePoints game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just homeTeamGoals, Just awayTeamGoals) ->
            if homeTeamGoals > awayTeamGoals then
                3
            else if homeTeamGoals < awayTeamGoals then
                0
            else    
                1
        (_, _) ->
            0

awayPoints: Game -> Int
awayPoints game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just homeTeamGoals, Just awayTeamGoals) ->
            if homeTeamGoals > awayTeamGoals then
                0
            else if homeTeamGoals < awayTeamGoals then
                3
            else    
                1
        (_, _) ->
            0

gamesPlayed: List Game -> String -> Int
gamesPlayed games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gameGamesPlayed teamName game) games)

gameGamesPlayed: String -> Game -> Int
gameGamesPlayed teamName game =
    case (game.homeTeamGoals, game.awayTeamGoals) of
        (Just _, Just _) ->
            if teamName == game.homeTeamName then
                1
            else if teamName == game.awayTeamName then
                1
            else    
                0
        (_, _) ->
            0

goalsAgainst: List Game -> String -> Int
goalsAgainst games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gameGoalsAgainst teamName game) games)

gameGoalsAgainst: String -> Game -> Int
gameGoalsAgainst teamName game =
    if teamName == game.homeTeamName then
        Maybe.withDefault 0 game.awayTeamGoals
    else if teamName == game.awayTeamName then
        Maybe.withDefault 0 game.homeTeamGoals
    else    
        0

goalsFor: List Game -> String -> Int
goalsFor games teamName =
    List.foldl (\gameGoals totalGoals -> totalGoals + gameGoals) 0 (List.map (\game -> gameGoalsFor teamName game) games)

gameGoalsFor: String -> Game -> Int
gameGoalsFor teamName game =
    if teamName == game.homeTeamName then
        Maybe.withDefault 0 game.homeTeamGoals
    else if teamName == game.awayTeamName then
        Maybe.withDefault 0 game.awayTeamGoals
    else    
        0

