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
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> expectDaysOrderedByDateDescending 

expectDaysOrderedByDateDescending: ResultsFixtures -> Expectation
expectDaysOrderedByDateDescending resultsFixtures =
    Expect.equal 
        (List.length resultsFixtures.days) 
        (
            List.Extra.groupWhileTransitively isGreaterThan (List.map .date resultsFixtures.days ) 
            |> List.length
        )

isGreaterThan: Maybe Date -> Maybe Date -> Bool
isGreaterThan maybeDate1 maybeDate2 = 
    case (maybeDate1, maybeDate2) of
        (Nothing, Nothing) -> 
            False
        (Nothing, Just _) ->
            False
        (Just _, Nothing) ->
            True
        (Just date1, Just date2) ->
            Date.Extra.compare date1 date2 == GT 
