module CalculateFixturesResultsFromLeagueGamesTest exposing (..)

import Time exposing (..)
import Time.Extra exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange, list)
import Expect exposing (Expectation)

import List.Extra exposing (gatherWith)
import Models.LeagueGames exposing (LeagueGames)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures, playerOccurrences)
import ResultsFixturesHelpers exposing (..)


groupsGamesByDay : Test
groupsGamesByDay =
    fuzz (list dateTimeInFebruary) "Groups all scheduled games into a LeagueGamesForDay for each day" <|
        \(dateTimes) ->
            let
                games = List.map scheduledGame dateTimes
                groupedDates =
                    List.map (Time.Extra.floor Day utc) dateTimes
                    |> List.sortWith comparePosix
                    |> List.reverse
                    |> gatherWith (==)
            in
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> expectNumberOfGamesForDates
                        (List.map
                            (\(firstDate, remainingDates)
                                -> GamesForDay (Just firstDate) (1 + List.length remainingDates))
                            groupedDates)

type alias GamesForDay =
    { date: Maybe Posix
    , numberOfGames: Int
    }

expectNumberOfGamesForDates: List GamesForDay -> ResultsFixtures -> Expectation
expectNumberOfGamesForDates expectedNumberOfDaysFordateTimes resultsFixtures =
    let
        actualNumberOfDaysFordateTimes = List.map (\leagueGamesForDay -> GamesForDay leagueGamesForDay.date (List.length leagueGamesForDay.games )) resultsFixtures.days
    in
        Expect.equalLists expectedNumberOfDaysFordateTimes actualNumberOfDaysFordateTimes

playerOccurrencesTest : Test
playerOccurrencesTest =
    test  "Groups player occurrences" <|
        \() ->
            playerOccurrences
                [ "john", "mike", "ed", "cedd", "mike", "cedd", "john", "john" ]
            |> Expect.equal
                [("cedd", 2), ("ed", 1), ("john", 3), ("mike", 2)]