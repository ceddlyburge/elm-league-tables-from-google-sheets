module CalculateTopScorersFromLeagueGamesTest exposing (..)

import Test exposing (..)
import Expect

import Models.Game exposing (Game, vanillaGame)
import Calculations.PlayersFromLeagueGames exposing (calculatePlayers)
import Models.Player exposing (..)


orderByGoalCount : Test
orderByGoalCount =
    test  "Order players by number of goals scored" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["Cedd", "Cedd"] "Meridian" ["Chad"] ]
            |> Expect.equal 
                [ Player (PlayerId "Castle" "Cedd") 2
                , Player (PlayerId "Meridian" "Chad") 1 
                ]

orderByGoalCountThenPlayerName : Test
orderByGoalCountThenPlayerName =
    test  "Order players by number of goals scored, then by player name" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["Chad"] "Meridian" ["Cedd"] ]
            |> Expect.equal 
                [ Player (PlayerId "Meridian" "Cedd") 1 
                , Player (PlayerId "Castle" "Chad") 1
                ]

orderByGoalCountThenPlayerNameThenTeamName : Test
orderByGoalCountThenPlayerNameThenTeamName =
    test  "Order players by number of goals scored, then by player name, then by team name" <|
        \() ->
            calculatePlayers 
                [ game "Meridian" ["Cedd"] "Castle" ["Cedd"] ]
            |> Expect.equal 
                [ Player (PlayerId "Castle" "Cedd") 1
                , Player (PlayerId "Meridian" "Cedd") 1 
                ]

multipleGames : Test
multipleGames =
    test  "Count scores across multiple games" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["Cedd"] "Meridian" ["Chad"]
                , game "Castle" ["Cedd", "Cedd", "Barry"] "Battersea" ["Chad"]  
                , game "Castle" [] "Meridian" ["Chad"]  
                ]
            |> Expect.equal 
                [ Player (PlayerId "Castle" "Cedd") 3
                , Player (PlayerId "Meridian" "Chad") 2 
                , Player (PlayerId "Castle" "Barry") 1 
                , Player (PlayerId "Battersea" "Chad") 1 
                ]

game: String -> List String -> String -> List String -> Game
game homeTeamName homeTeamGoals awayTeamName awayTeamGoals = 
    { vanillaGame | 
        homeTeamName = homeTeamName
        , homeGoals = homeTeamGoals
        , awayTeamName = awayTeamName
        , awayGoals = awayTeamGoals
    }
