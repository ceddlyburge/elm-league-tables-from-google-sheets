module GameTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list)
import Models.Game exposing (..)
import Test exposing (..)
import Time exposing (..)
import Time.Extra exposing (..)


homeTeamGoalsTest : Test
homeTeamGoalsTest =
    test "Groups home team player occurrences" <|
        \() ->
            homeTeamGoals { vanillaGame | homeTeamGoals = [ "john", "mike", "ed", "cedd", "mike", "cedd", "john", "john" ] }
                |> Expect.equal [ ( "cedd", 2 ), ( "ed", 1 ), ( "john", 3 ), ( "mike", 2 ) ]


awayTeamGoalsTest : Test
awayTeamGoalsTest =
    test "Groups away team player occurrences" <|
        \() ->
            awayTeamGoals { vanillaGame | awayTeamGoals = [ "john", "mike", "ed", "cedd", "mike", "cedd", "john", "john" ] }
                |> Expect.equal [ ( "cedd", 2 ), ( "ed", 1 ), ( "john", 3 ), ( "mike", 2 ) ]


-- playerOccurrencesTest : Test
-- playerOccurrencesTest =
--     test "Groups player occurrences" <|
--         \() ->
--             playerOccurrences
--                 [ "john", "mike", "ed", "cedd", "mike", "cedd", "john", "john" ]
--                 |> Expect.equal
--                     [ ( "cedd", 2 ), ( "ed", 1 ), ( "john", 3 ), ( "mike", 2 ) ]
