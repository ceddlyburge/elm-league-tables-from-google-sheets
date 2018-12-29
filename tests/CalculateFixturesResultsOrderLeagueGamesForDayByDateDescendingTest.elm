module CalculateFixturesResultsOrderLeagueGamesForDayByDateDescendingTest exposing (..)

import Date exposing (..)
import Date.Extra exposing (..)
import List.Extra exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange, list)
import Expect exposing (Expectation)

import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import ResultsFixturesHelpers exposing (..)

-- could add a fuzzer to create the games directly, instead of going via the list int
-- it might make the test output more readable
orderDaysByDateDescending : Test
orderDaysByDateDescending =
    fuzz (list (intRange 0 10)) "Order LeagueGamesForDay by descending date. Unscheduled goes last." <|
        \(dateVariations) ->
            let
                dates = List.map (\dateVariation -> Date.Extra.add Day dateVariation (Date.Extra.fromCalendarDate 2001 Feb 27) ) dateVariations
                games = List.map scheduledGame dates
                descendingDates = 
                    List.Extra.uniqueBy (Date.Extra.ordinalDay) dates -- this relies on the dates all being in the same year
                    |> List.sortWith Date.Extra.compare
                    |> List.reverse
                    |> List.map Just
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> .days
                |> List.map .date
                |> Expect.equalLists descendingDates
