module CalculateLeagueTableFromLeagueGamesTest exposing (calculatesOneGame)

import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)
import Expect
import Fuzz exposing (intRange)
import Helpers exposing (vanillaDecodedGame)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (Team)
import Test exposing (Test, fuzz)
import Time exposing (Month(..), utc)
import Time.Extra exposing (Parts, partsToPosix)


calculatesOneGame : Test
calculatesOneGame =
    fuzz (intRange 1 100) "Calculates one game" <|
        \meridianGoals ->
            -- using these let statements exercises a compiler bug, so have inlined them
            -- let
            --     -- castleGoalDifference : number
            --     -- castleGoalDifference =
            --     --     meridianGoals
            --     -- meridianGoalDifference : number
            --     -- meridianGoalDifference =
            --     --     -meridianGoals
            --     -- castleGoals : number
            --     -- castleGoals =
            --     --     meridianGoals * 2
            -- in
            calculateLeagueTable (LeagueGames "Regional Div 1" [ game (meridianGoals * 2) meridianGoals ])
                |> Expect.equal (leagueTable (meridianGoals * 2) meridianGoals meridianGoals -meridianGoals)


game : Int -> Int -> DecodedGame
game castleGoals meridianGoals =
    { vanillaDecodedGame
        | homeTeamName = "Meridian"
        , homeTeamGoalCount = Just meridianGoals
        , awayTeamName = "Castle"
        , awayTeamGoalCount = Just castleGoals
        , datePlayed = Just (partsToPosix utc (Parts 1970 Jan 1 0 0 0 1))
    }


leagueTable : Int -> Int -> Int -> Int -> LeagueTable
leagueTable castleGoals meridianGoals castleGoalDifference meridianGoalDifference =
    LeagueTable
        "Regional Div 1"
        [ Team 1 "Castle" 1 1 0 0 3 castleGoals meridianGoals castleGoalDifference
        , Team 2 "Meridian" 1 0 0 1 0 meridianGoals castleGoals meridianGoalDifference
        ]
