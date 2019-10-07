module CalculateFixturesResultsOrderGamesWithinDayByDateTest exposing (..)

-- import Date exposing (..)
-- import Date.Extra exposing (..)
import Time exposing (..)
import Time.Extra exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange, list)
import Expect exposing (Expectation)

import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import ResultsFixturesHelpers exposing (..)

comparePosix: Posix -> Posix -> Order
comparePosix date1 date2 =
    compare (posixToMillis date1) (posixToMillis date2)

orderGamesByTime : Test
orderGamesByTime =
    fuzz (list dateTimeOnFebruaryFirst) "Games within a LeagueGamesForDay should be ordered by time" <|
        \(timesInDay) ->
            let
                games = List.map scheduledGame timesInDay
                sortedTimes = 
                    List.sortWith comparePosix timesInDay -- Time.Extra.compare timesInDay 
                    |> List.map Just
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> expectFirstDay (expectGames sortedTimes)
                    
expectGames: List (Maybe Posix) -> Maybe LeagueGamesForDay -> Expectation
expectGames expectedTimes leagueGamesForDay =
    Expect.equalLists 
        expectedTimes 
        (Maybe.map .games leagueGamesForDay 
        |> Maybe.withDefault []
        |> List.map .datePlayed)

dateTimeOnFebruaryFirst : Fuzzer Posix
dateTimeOnFebruaryFirst =
    Fuzz.map 
        (\hours -> 
            (Time.Extra.partsToPosix utc (Parts 2001 Feb 1 0 0 0 0)) -- Time.Extra.fromCalendarDate 2001 Feb 1
            |> Time.Extra.add Hour hours utc
        )
        (intRange 0 23)
    
