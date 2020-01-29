module CalculateLeagueTableFromLeagueGamesTest exposing (..)

import Time exposing (..)
import Time.Extra exposing (..)
import Test exposing (..)
import Fuzz exposing (Fuzzer, intRange)
import Expect

import Models.LeagueTable exposing (LeagueTable)
import Models.DecodedGame exposing (DecodedGame, vanillaGame)
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

game: Int -> Int -> DecodedGame
game castleGoals meridianGoals = 
    { vanillaGame | 
        homeTeamName = "Meridian"
        , homeTeamGoalCount = (Just meridianGoals)
        , awayTeamName = "Castle"
        , awayTeamGoalCount = (Just castleGoals)
        , datePlayed = (Just (Time.Extra.partsToPosix utc (Parts 1970 Jan 1 0 0 0 1)))
    }

leagueTable: Int -> Int -> Int -> Int -> LeagueTable
leagueTable castleGoals meridianGoals castleGoalDifference meridianGoalDifference = 
    LeagueTable 
        "Regional Div 1" 
        [ 
              Team 1 "Castle"   1 1 0 0 3 castleGoals   meridianGoals castleGoalDifference
            , Team 2 "Meridian" 1 0 0 1 0 meridianGoals castleGoals   meridianGoalDifference
        ]
