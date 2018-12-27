module Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)

import Date exposing (..)
import Date.Extra exposing (..)

import List.Gather exposing (..)
import Models.LeagueGames exposing (LeagueGames)
import Models.Game exposing (Game)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Models.ResultsFixtures exposing (ResultsFixtures)

calculateResultsFixtures: LeagueGames -> ResultsFixtures
calculateResultsFixtures leagueGames =
    ResultsFixtures 
        leagueGames.leagueTitle 
        (groupGamesByDate leagueGames.games
        |> List.map leagueGamesForDay
        |> List.sortWith descendingDate)

groupGamesByDate: List Game -> List (Game, List Game)
groupGamesByDate games =
    List.Gather.gatherWith (\game1 game2 -> game1.datePlayed == game2.datePlayed)  games

leagueGamesForDay: (Game, List Game) -> LeagueGamesForDay
leagueGamesForDay (firstGame, remainingGames) = 
    LeagueGamesForDay 
        firstGame.datePlayed
        (firstGame :: remainingGames)

dateOfFirstGame: List Game -> Maybe Date
dateOfFirstGame games =
    Maybe.andThen (\game -> game.datePlayed) (List.head games)

-- if this kind of date comparison is required again, create function to use Maybe Date's
-- instead of LeagueGamesForDay's, so the code is more reusable. Then call that function
-- from this one.
descendingDate: LeagueGamesForDay -> LeagueGamesForDay -> Order
descendingDate day1 day2 =
    case (day1.date, day2.date) of
        (Nothing, Nothing) -> 
            EQ
        (Nothing, Just _) ->
            GT
        (Just _, Nothing) ->
            LT
        (Just date1, Just date2) ->
            Date.Extra.compare date2 date1
