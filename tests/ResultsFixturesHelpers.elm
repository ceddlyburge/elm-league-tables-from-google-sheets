module ResultsFixturesHelpers exposing (..)

import Time exposing (..)
import Time.Extra exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list)

import Models.Game exposing (Game, vanillaGame)
import Models.ResultsFixtures exposing (ResultsFixtures)
import Models.LeagueGamesForDay exposing (LeagueGamesForDay)

comparePosix: Posix -> Posix -> Order
comparePosix date1 date2 =
    compare (posixToMillis date1) (posixToMillis date2)

expectDays: Int -> ResultsFixtures -> Expectation
expectDays expectedNumberOfDays resultsFixtures =
    Expect.equal expectedNumberOfDays (List.length resultsFixtures.days)

expectFirstDay: (Maybe LeagueGamesForDay -> Expectation) -> ResultsFixtures -> Expectation
expectFirstDay expect resultsFixtures =
    expect (List.head resultsFixtures.days)

unscheduledGame: Game
unscheduledGame = 
    vanillaGame
    
scheduledGame: Posix -> Game
scheduledGame date = 
    { vanillaGame | datePlayed = Just date }

dateTimeInFebruary : Fuzzer Posix
dateTimeInFebruary =
    Fuzz.map2 
        (\days hours -> 
            (Time.Extra.partsToPosix utc (Parts 2001 Feb 27 0 0 0 0))
            |> Time.Extra.add Day days utc 
            |> Time.Extra.add Hour hours utc 
        )
        (intRange 0 10)
        (intRange 0 23)
