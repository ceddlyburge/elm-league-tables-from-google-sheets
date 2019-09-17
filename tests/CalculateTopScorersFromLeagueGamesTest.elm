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
            |> .players
            |> Expect.equal 
                [ player (PlayerId "Castle" "Cedd") 2
                , player (PlayerId "Meridian" "Chad") 1 
                ]

orderByGoalCountThenPlayerName : Test
orderByGoalCountThenPlayerName =
    test  "Order players by number of goals scored, then by player name" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["Chad"] "Meridian" ["Cedd"] ]
            |> .players
            |> Expect.equal 
                [ player (PlayerId "Meridian" "Cedd") 1 
                , player (PlayerId "Castle" "Chad") 1
                ]

orderByGoalCountThenPlayerNameThenTeamName : Test
orderByGoalCountThenPlayerNameThenTeamName =
    test  "Order players by number of goals scored, then by player name, then by team name" <|
        \() ->
            calculatePlayers 
                [ game "Meridian" ["Cedd"] "Castle" ["Cedd"] ]
            |> .players
            |> Expect.equal 
                [ player (PlayerId "Castle" "Cedd") 1
                , player (PlayerId "Meridian" "Cedd") 1 
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
            |> .players
            |> Expect.equal 
                [ player (PlayerId "Castle" "Cedd") 3
                , player (PlayerId "Meridian" "Chad") 2 
                , player (PlayerId "Castle" "Barry") 1 
                , player (PlayerId "Battersea" "Chad") 1 
                ]

removeBlanks : Test
removeBlanks =
    test  "Remove players with blank or whitespace names" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["", "\t"] "Meridian" [" ", "\r\n"] ]
            |> .players
            |> Expect.equal 
                []

anonymousPlayers : Test
anonymousPlayers =
    test  "Players without alphabetic characters in their name are not 'named'" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["1", " 2"] "Meridian" ["3 ", "?"] ]
            |> .namedPlayerDataAvailable
            |> Expect.equal 
                False

namedPlayers : Test
namedPlayers =
    test  "A player is 'named' if they have alphabetic characters in their name" <|
        \() ->
            calculatePlayers 
                [ game "Castle" ["c"] "Meridian" [] ]
            |> .namedPlayerDataAvailable
            |> Expect.equal 
                True

game: String -> List String -> String -> List String -> Game
game homeTeamName homeTeamGoals awayTeamName awayTeamGoals = 
    { vanillaGame | 
        homeTeamName = homeTeamName
        , homeGoals = homeTeamGoals
        , awayTeamName = awayTeamName
        , awayGoals = awayTeamGoals
    }
