module CalculateLeagueTableFromLeagueGamesTest exposing (..)

import Date exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange)
import Expect

import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game, vanillaGame)
import Models.LeagueGames exposing (LeagueGames)
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
    { vanillaGame | 
        homeTeamName = "Meridian"
        , homeTeamGoals = (Just meridianGoals)
        , awayTeamName = "Castle"
        , awayTeamGoals = (Just castleGoals)
        , datePlayed = (Just <| Date.fromTime 1)
    }

leagueTable: Int -> Int -> Int -> Int -> LeagueTable
leagueTable castleGoals meridianGoals castleGoalDifference meridianGoalDifference = 
    LeagueTable 
        "Regional Div 1" 
        [ 
              Team 1 "Castle"   1 1 0 0 3 castleGoals   meridianGoals castleGoalDifference
            , Team 2 "Meridian" 1 0 0 1 0 meridianGoals castleGoals   meridianGoalDifference
        ]
