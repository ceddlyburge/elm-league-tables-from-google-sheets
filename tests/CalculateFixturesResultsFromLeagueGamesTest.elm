module CalculateFixturesResultsFromLeagueGamesTest exposing (..)

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
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)


groupsGamesByDay : Test
groupsGamesByDay =
    fuzz (list (intRange 0 10)) "Groups all scheduled games into a LeagueGamesForDay for each day" <|
        \(dateVariations) ->
            let
                dates = List.map (\dateVariation -> Date.Extra.add Day dateVariation (Date.Extra.fromCalendarDate 2001 Feb 27) ) dateVariations
                games = List.map scheduledGame dates
                groupedDates = List.Extra.group dates
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> Expect.all [
                        expectDays <| List.length groupedDates
                        , expectNumberOfGamesForDates <| List.map (\datesInGroup -> GamesForDay (List.head datesInGroup) (List.length datesInGroup)) groupedDates
                    ]

groupsUnscheduledGamesInNothingDay : Test
groupsUnscheduledGamesInNothingDay =
    fuzz (intRange 1 100) "Groups all unscheduled games in a LeagueGamesForDay with a 'Nothing' day" <|
        \(numberOfGames) ->
            let
                games = List.repeat numberOfGames unscheduledGame
            in    
                calculateResultsFixtures (LeagueGames "Any League Title" games)
                |> Expect.all [
                        expectDays 1
                        , expectFirstDay <| expectDate Nothing
                        , expectFirstDay <| expectNumberOfGames numberOfGames
                    ]

type alias GamesForDay =
    { date: Maybe Date
    , numberOfGames: Int 
    }

scheduledGame: Date -> Game
scheduledGame date = 
    Game "" Nothing "" Nothing (Just date) "" "" "" "" ""

unscheduledGame: Game
unscheduledGame = 
    Game "" Nothing "" Nothing Nothing "" "" "" "" ""

expectDays: Int -> ResultsFixtures -> Expectation
expectDays expectedNumberOfDays resultsFixtures =
    Expect.equal expectedNumberOfDays (List.length resultsFixtures.days)

expectNumberOfGamesForDates: List GamesForDay -> ResultsFixtures -> Expectation
expectNumberOfGamesForDates expectedNumberOfDaysForDates resultsFixtures =
    let
        actualNumberOfDaysForDates = List.map (\leagueGamesForDay -> GamesForDay leagueGamesForDay.date (List.length leagueGamesForDay.games )) resultsFixtures.days
    in    
        Expect.equalLists expectedNumberOfDaysForDates actualNumberOfDaysForDates

expectFirstDay: (Maybe LeagueGamesForDay -> Expectation) -> ResultsFixtures -> Expectation
expectFirstDay expect resultsFixtures =
    expect (List.head resultsFixtures.days)

expectDate: Maybe Date -> Maybe LeagueGamesForDay -> Expectation
expectDate expectedDate leagueGamesForDay =
    Expect.equal expectedDate (Maybe.andThen (\day -> day.date) leagueGamesForDay)

expectNumberOfGames: Int -> Maybe LeagueGamesForDay -> Expectation
expectNumberOfGames expectedNumberOfGames leagueGamesForDay =
    Expect.equal (Just expectedNumberOfGames) (Maybe.map (\day -> List.length day.games) leagueGamesForDay)