module CalculateFixturesResultsUnscheduledGamesTest exposing (..)

import Date exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange, list)
import Expect exposing (Expectation)

import Models.Game exposing (Game)
import Models.LeagueGames exposing (LeagueGames)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Calculations.ResultsFixturesFromLeagueGames exposing (calculateResultsFixtures)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)
import ResultsFixturesHelpers exposing (..)

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

expectDate: Maybe Date -> Maybe LeagueGamesForDay -> Expectation
expectDate expectedDate leagueGamesForDay =
    Expect.equal expectedDate (Maybe.andThen (\day -> day.date) leagueGamesForDay)

expectNumberOfGames: Int -> Maybe LeagueGamesForDay -> Expectation
expectNumberOfGames expectedNumberOfGames leagueGamesForDay =
    Expect.equal (Just expectedNumberOfGames) (Maybe.map (\day -> List.length day.games) leagueGamesForDay)

unscheduledGame: Game
unscheduledGame = 
    Game "" Nothing "" Nothing Nothing "" "" "" "" ""