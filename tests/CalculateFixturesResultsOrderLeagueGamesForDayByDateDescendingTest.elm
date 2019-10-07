module CalculateFixturesResultsOrderLeagueGamesForDayByDateDescendingTest exposing (..)

-- import Date.Extra exposing (..)
import Time exposing (..)
import Time.Extra exposing (..)
import List.Extra exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange, list)
import Expect exposing (Expectation)

import Models.LeagueGames exposing (LeagueGames)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import ResultsFixturesHelpers exposing (..)

comparePosix: Posix -> Posix -> Order
comparePosix date1 date2 =
    compare (posixToMillis date1) (posixToMillis date2)


orderDaysByDateDescending : Test
orderDaysByDateDescending =
    fuzz (list dateTimeInFebruary) "Order LeagueGamesForDay by descending date, unscheduled go last" <|
        \(dateTimes) ->
            let
                games = unscheduledGame :: List.map scheduledGame dateTimes
                descendingDates = 
                    List.map (Time.Extra.floor Day utc) dateTimes
                    |> List.Extra.uniqueBy posixToMillis -- (Time.Extra.ordinalDay) -- this relies on the dates all being in the same year
                    |> List.sortWith comparePosix -- Time.Extra.compare
                    |> List.map Just
                    |> (::) Nothing
                    |> List.reverse
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> .days
                |> List.map .date
                |> Expect.equalLists descendingDates
