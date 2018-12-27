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

-- could add a fuzzer to create the dates, instead of doing it via the int fuzzer
-- the output from this test when it fails is not that revealing
-- this test is maybe too complicated, maybe it would be better to set it up manually instead of using fuzzers
groupsGamesByDay : Test
groupsGamesByDay =
    fuzz (list (intRange 0 10)) "Groups all scheduled games into a LeagueGamesForDay for each day" <|
        \(dateVariations) ->
            let
                dates = List.map (\dateVariation -> Date.Extra.add Day dateVariation (Date.Extra.fromCalendarDate 2001 Feb 27) ) dateVariations
                games = List.map scheduledGame dates
                sortedDates = List.sortWith Date.Extra.compare dates |> List.reverse
                groupedDates = List.Gather.gatherWith (==) sortedDates
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> Expect.all [
                        expectDays <| List.length groupedDates
                        , expectNumberOfGamesForDates <| 
                            List.map 
                                (\(firstDate, remainingDates) 
                                    -> GamesForDay (Just firstDate) (1 + (List.length remainingDates))) 
                                groupedDates 
                    ]

type alias GamesForDay =
    { date: Maybe Date
    , numberOfGames: Int 
    }

expectNumberOfGamesForDates: List GamesForDay -> ResultsFixtures -> Expectation
expectNumberOfGamesForDates expectedNumberOfDaysForDates resultsFixtures =
    let
        actualNumberOfDaysForDates = List.map (\leagueGamesForDay -> GamesForDay leagueGamesForDay.date (List.length leagueGamesForDay.games )) resultsFixtures.days
    in    
        Expect.equalLists expectedNumberOfDaysForDates actualNumberOfDaysForDates