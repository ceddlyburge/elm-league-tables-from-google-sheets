module CalculateFixturesResultsFromLeagueGamesTest exposing (..)

import Date exposing (..)
import Date.Extra exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange, list)
import Expect exposing (Expectation)

import List.Gather exposing (..)
import Models.LeagueGames exposing (LeagueGames)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import ResultsFixturesHelpers exposing (..)

-- add test for order of results / fixtures within a day

-- this test is maybe too complicated, maybe it would be better to set it up manually instead of using fuzzers
groupsGamesByDay : Test
groupsGamesByDay =
    fuzz (list dateTimeInFebruary) "Groups all scheduled games into a LeagueGamesForDay for each day" <|
        \(dateTimes) ->
            let
                games = List.map scheduledGame dateTimes
                groupedDates = 
                    List.map (Date.Extra.floor Day) dateTimes
                    |> List.sortWith Date.Extra.compare
                    |> List.reverse
                    |> List.Gather.gatherWith (==)
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> expectNumberOfGamesForDates 
                        (List.map 
                            (\(firstDate, remainingDates) 
                                -> GamesForDay (Just firstDate) (1 + (List.length remainingDates))) 
                            groupedDates)

type alias GamesForDay =
    { date: Maybe Date
    , numberOfGames: Int 
    }

expectNumberOfGamesForDates: List GamesForDay -> ResultsFixtures -> Expectation
expectNumberOfGamesForDates expectedNumberOfDaysFordateTimes resultsFixtures =
    let
        actualNumberOfDaysFordateTimes = List.map (\leagueGamesForDay -> GamesForDay leagueGamesForDay.date (List.length leagueGamesForDay.games )) resultsFixtures.days
    in    
        Expect.equalLists expectedNumberOfDaysFordateTimes actualNumberOfDaysFordateTimes

dateTimeInFebruary : Fuzzer Date
dateTimeInFebruary =
    Fuzz.map2 
        (\days hours -> 
            Date.Extra.fromCalendarDate 2001 Feb 27
            |> Date.Extra.add Day days
            |> Date.Extra.add Hour hours
        )
        (intRange 0 10)
        (intRange 0 23)
    
