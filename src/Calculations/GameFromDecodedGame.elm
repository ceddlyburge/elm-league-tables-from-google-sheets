module Calculations.GameFromDecodedGame exposing (calculateGame)

import Dict exposing (toList)
import Dict.Extra exposing (groupBy)
import Models.DecodedGame exposing (DecodedGame)
import Models.Game exposing (Game)
import Models.RealName exposing (hasRealName)

calculateGame : DecodedGame -> Game
calculateGame decodedGame =
    Game
        decodedGame.homeTeamName
        decodedGame.homeTeamGoalCount
        decodedGame.awayTeamName
        decodedGame.awayTeamGoalCount
        decodedGame.datePlayed
        (aggregateGoals decodedGame.homeTeamGoals)
        (aggregateGoals decodedGame.awayTeamGoals)
        decodedGame.homeTeamCards
        decodedGame.awayTeamCards
        decodedGame.notes


aggregateGoals : List String -> String
aggregateGoals goals =
    List.filter hasRealName goals
        |> Dict.Extra.groupBy identity
        |> Dict.toList
        |> List.map (\( playerName, occurrencesOfPlayerName ) -> ( playerName, List.length occurrencesOfPlayerName ))
        |> List.map formatPlayerOccurrences
        |> String.join ", "


formatPlayerOccurrences : ( String, Int ) -> String
formatPlayerOccurrences ( playerName, timesScored ) =
    if timesScored <= 1 then
        playerName

    else
        playerName ++ " (" ++ String.fromInt timesScored ++ ")"

