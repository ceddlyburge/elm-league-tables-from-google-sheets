module ResultsFixturesHelpers exposing (..)

import Date exposing (..)
import Expect exposing (Expectation)

import Models.Game exposing (Game)
import Models.ResultsFixtures exposing (ResultsFixtures)

expectDays: Int -> ResultsFixtures -> Expectation
expectDays expectedNumberOfDays resultsFixtures =
    Expect.equal expectedNumberOfDays (List.length resultsFixtures.days)

vanillaGame : Game
vanillaGame = 
    Game "" Nothing "" Nothing Nothing "" "" "" "" "" 

scheduledGame: Date -> Game
scheduledGame date = 
    Game "" Nothing "" Nothing (Just date) "" "" "" "" ""

