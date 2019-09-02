module ResultsFixturesHelpers exposing (..)

import Date exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list)
import Date.Extra exposing (..)

import Models.Game exposing (Game)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)

expectDays: Int -> ResultsFixtures -> Expectation
expectDays expectedNumberOfDays resultsFixtures =
    Expect.equal expectedNumberOfDays (List.length resultsFixtures.days)

expectFirstDay: (Maybe LeagueGamesForDay -> Expectation) -> ResultsFixtures -> Expectation
expectFirstDay expect resultsFixtures =
    expect (List.head resultsFixtures.days)

unscheduledGame: Game
unscheduledGame = 
    Game "" Nothing "" Nothing Nothing [] "" "" "" "" ""
    
scheduledGame: Date -> Game
scheduledGame date = 
    Game "" Nothing "" Nothing (Just date) [] "" "" "" "" ""

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
