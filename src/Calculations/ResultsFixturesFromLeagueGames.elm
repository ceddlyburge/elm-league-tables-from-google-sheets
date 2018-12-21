module Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

import List.Extra exposing (..)
import Date exposing (..)
import Models.LeagueGames exposing (LeagueGames)
import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)

calculateResultsFixtures: LeagueGames -> ResultsFixtures
calculateResultsFixtures leagueGames =
    ResultsFixtures 
        leagueGames.leagueTitle 
        (List.map 
            leagueGamesForDay
             <| groupGamesByDate leagueGames.games)

groupGamesByDate: List Game -> List (List Game)
groupGamesByDate games =
    List.Extra.groupWhile (\game1 game2 -> game1.datePlayed == game2.datePlayed)  games

leagueGamesForDay: List Game -> LeagueGamesForDay
leagueGamesForDay gamesForDay = 
    LeagueGamesForDay 
        (dateOfFirstGame gamesForDay)
        gamesForDay

dateOfFirstGame: List Game -> Maybe Date
dateOfFirstGame games =
    Maybe.andThen (\game -> game.datePlayed) (List.head games)
