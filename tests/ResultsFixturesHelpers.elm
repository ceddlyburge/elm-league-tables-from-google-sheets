module ResultsFixturesHelpers exposing (..)

import Date exposing (..)
import Expect exposing (Expectation)

import Models.Game exposing (Game)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)

expectDays: Int -> ResultsFixtures -> Expectation
expectDays expectedNumberOfDays resultsFixtures =
    Expect.equal expectedNumberOfDays (List.length resultsFixtures.days)

expectFirstDay: (Maybe LeagueGamesForDay -> Expectation) -> ResultsFixtures -> Expectation
expectFirstDay expect resultsFixtures =
    expect (List.head resultsFixtures.days)

vanillaGame : Game
vanillaGame = 
    Game "" Nothing "" Nothing Nothing "" "" "" "" "" 

scheduledGame: Date -> Game
scheduledGame date = 
    Game "" Nothing "" Nothing (Just date) "" "" "" "" ""

