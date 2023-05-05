module CalculateFixturesResultsOrderGamesWithinDayByDateTest exposing (orderGamesByTime)

import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import ResultsFixturesHelpers exposing (comparePosix, expectFirstDay, scheduledGame)
import Test exposing (Test, fuzz)
import Time exposing (Month(..), Posix, utc)
import Time.Extra exposing (Interval(..), Parts)


orderGamesByTime : Test
orderGamesByTime =
    fuzz (list dateTimeOnFebruaryFirst) "Games within a LeagueGamesForDay should be ordered by time" <|
        \timesInDay ->
            let
                games : List DecodedGame
                games =
                    List.map scheduledGame timesInDay

                sortedTimes : List (Maybe Posix)
                sortedTimes =
                    List.sortWith comparePosix timesInDay
                        |> List.map Just
            in
            calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> expectFirstDay (expectGames sortedTimes)


expectGames : List (Maybe Posix) -> Maybe LeagueGamesForDay -> Expectation
expectGames expectedTimes leagueGamesForDay =
    Expect.equalLists
        expectedTimes
        (Maybe.map .games leagueGamesForDay
            |> Maybe.withDefault []
            |> List.map .datePlayed
        )


dateTimeOnFebruaryFirst : Fuzzer Posix
dateTimeOnFebruaryFirst =
    Fuzz.map
        (\hours ->
            Time.Extra.partsToPosix utc (Parts 2001 Feb 1 0 0 0 0)
                |> Time.Extra.add Hour hours utc
        )
        (intRange 0 23)
