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
    List.Gather.gatherWith gameDatesEqual games

gameDatesEqual: Game -> Game -> Bool
gameDatesEqual game1 game2 = 
    maybeDatesEqual game1.datePlayed game2.datePlayed

maybeDatesEqual: Maybe Date -> Maybe Date -> Bool
maybeDatesEqual maybeDate1 maybeDate2 = 
    (Maybe.map2 datesEqual maybeDate1 maybeDate2) == (Just True)
    || maybeDate1 == maybeDate2

datesEqual: Date -> Date -> Bool
datesEqual date1 date2 = 
    Date.Extra.floor Day date1 == Date.Extra.floor Day date2

leagueGamesForDay: (Game, List Game) -> LeagueGamesForDay
leagueGamesForDay (firstGame, remainingGames) = 
    LeagueGamesForDay
        (Maybe.map (Date.Extra.floor Day) firstGame.datePlayed)
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
