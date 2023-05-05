module CalculateGameFromDecodedGameTest exposing (aggregateGoalsTest)

import Calculations.GameFromDecodedGame exposing (calculateGame)
import Expect
import Helpers exposing (vanillaDecodedGame)
import Test exposing (Test, test)


aggregateGoalsTest : Test
aggregateGoalsTest =
    test "Groups home team player occurrences and ignores numbers" <|
        \() ->
            { vanillaDecodedGame
                | homeTeamGoals = [ "john", "11", "mike", "ed", "cedd", "mike", "cedd", "john", "john" ]
            }
                |> calculateGame
                |> .homeTeamGoals
                |> Expect.equal "cedd (2), ed, john (3), mike (2)"
