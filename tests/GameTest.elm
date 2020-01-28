module GameTest exposing (aggregateGoalsTest)

import Expect
import Models.Game exposing (aggregateGoals)
import Test exposing (Test, test)


aggregateGoalsTest : Test
aggregateGoalsTest =
    test "Groups home team player occurrences and ignores numbers" <|
        \() ->
            aggregateGoals [ "john", "11", "mike", "ed", "cedd", "mike", "cedd", "john", "john" ]
                |> Expect.equal "cedd (2), ed, john (3), mike (2)"
