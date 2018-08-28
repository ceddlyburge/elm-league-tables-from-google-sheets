module CalculateLeagueTableFromLeagueGamesTest exposing (..)

import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange)
import Expect

import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game, LeagueGames)
import Models.Team exposing (Team)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

oneGame : Test
oneGame =
    fuzz (intRange 1 100) "Calculates one game" <|
        \(meridianGoals) ->
            let
                castleGoals = meridianGoals * 2
                castleGoalDifference = meridianGoals
                meridianGoalDifference = -meridianGoals
            in    
                calculateLeagueTable (LeagueGames "Regional Div 1" [ game castleGoals meridianGoals ])
                |> Expect.equal (leagueTable castleGoals meridianGoals castleGoalDifference meridianGoalDifference)

game: Int -> Int -> Game
game castleGoals meridianGoals = 
    Game "Meridian" (Just meridianGoals) "Castle" (Just castleGoals) "2018-06-04" "1, 6, 4" "2" "Green 3, Yellow 5" "Red 14" "good game"

leagueTable: Int -> Int -> Int -> Int -> LeagueTable
leagueTable castleGoals meridianGoals castleGoalDifference meridianGoalDifference = 
    LeagueTable 
        "Regional Div 1" 
        [ 
              Team "Castle"   1 3 castleGoals   meridianGoals castleGoalDifference
            , Team "Meridian" 1 0 meridianGoals castleGoals   meridianGoalDifference
        ]
