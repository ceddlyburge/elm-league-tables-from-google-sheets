module CalculateFixturesResultsOrderLeagueGamesForDayByDateDescendingTest exposing (orderDaysByDateDescending)

import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Expect
import Fuzz exposing (list)
import List.Extra
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import ResultsFixturesHelpers exposing (comparePosix, dateTimeInFebruary, scheduledGame, unscheduledGame)
import Test exposing (Test, fuzz)
import Time exposing (posixToMillis, utc)
import Time.Extra exposing (Interval(..))


orderDaysByDateDescending : Test
orderDaysByDateDescending =
    fuzz (list dateTimeInFebruary) "Order LeagueGamesForDay by descending date, unscheduled go last" <|
        \dateTimes ->
            let
                games : List DecodedGame
                games =
                    unscheduledGame :: List.map scheduledGame dateTimes

                descendingDates : List (Maybe Time.Posix)
                descendingDates =
                    List.map (Time.Extra.floor Day utc) dateTimes
                        |> List.Extra.uniqueBy posixToMillis
                        |> List.sortWith comparePosix
                        |> List.map Just
                        |> (::) Nothing
                        |> List.reverse
            in
            calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> .days
                |> List.map .date
                |> Expect.equalLists descendingDates
