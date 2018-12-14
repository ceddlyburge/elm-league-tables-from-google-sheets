module CalculateFixturesResultsFromLeagueGamesTest exposing (..)

import Date exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange)
import Expect exposing (Expectation)

import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Models.Team exposing (Team)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)


-- what tests do I want
-- multiple games on same date. fuzz the number of games and the date, check that result has one date with that number of games in
-- multiple games all on different dates. 
-- one game with no date. check it goes in to a maybe date day

-- multiple unscheduled games
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

unscheduledGame: Game
unscheduledGame = 
    Game "" Nothing "" Nothing Nothing "" "" "" "" ""

expectDays: Int -> ResultsFixtures -> Expectation
expectDays expectedNumberOfDays resultsFixtures =
    Expect.equal expectedNumberOfDays (List.length resultsFixtures.days)

expectFirstDay: (Maybe LeagueGamesForDay -> Expectation) -> ResultsFixtures -> Expectation
expectFirstDay expect resultsFixtures =
    expect (List.head resultsFixtures.days)

expectDate: Maybe Date -> Maybe LeagueGamesForDay -> Expectation
expectDate expectedDate leagueGamesForDay =
    Expect.equal expectedDate (Maybe.andThen (\day -> day.date) leagueGamesForDay)

expectNumberOfGames: Int -> Maybe LeagueGamesForDay -> Expectation
expectNumberOfGames expectedNumberOfGames leagueGamesForDay =
    Expect.equal (Just expectedNumberOfGames) (Maybe.map (\day -> List.length day.games) leagueGamesForDay)