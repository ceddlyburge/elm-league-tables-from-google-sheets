module CalculateLeagueTableFromLeagueGamesTest exposing (..)

import Test exposing (..)
import Fuzz exposing (Fuzzer, list, string)
import Expect

import Models.LeagueTable exposing (LeagueTable)
import Models.Game exposing (Game, LeagueGames)
import Models.Team exposing (Team)
import Calculations.LeagueTableFromLeagueGames exposing (calculateLeagueTable)

apiSuccess : Test
apiSuccess =
    test "Calculates one game" <|
        \() ->
            calculateLeagueTable (LeagueGames "Regional Div 1" [ game ])
            |> Expect.equal leagueTable

game: Game
game = 
    Game "Castle" 3 "Meridian" 1 "2018-06-04" "1, 6, 4" "2" "Green 3, Yellow 5" "Red 14" "good game"

leagueTable: LeagueTable
leagueTable = 
    LeagueTable 
        "Regional Div 1" 
        [ 
            Team "Castle" 1 3 3 1 2
            , Team "Meridian" 1 0 1 3 -2
        ]
