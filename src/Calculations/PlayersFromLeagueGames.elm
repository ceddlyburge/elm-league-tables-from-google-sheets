module Calculations.PlayersFromLeagueGames exposing (calculatePlayers)

import Calculations.SortBy exposing (..)
import Dict exposing (..)
import Models.DecodedGame exposing (DecodedGame)
import Models.Player exposing (..)



-- Its annoying that I can't using PlayerId as a key to the Dict
-- and instead have to convert it to a tuple
-- Later players might contain other things, such as cards / penalties
-- Then we will probably store the players in a list in the model,
-- and provide functions to sort that list for the various atributes.
-- For now though, there is only one use case, so store the sorted
-- list.


calculatePlayers : List DecodedGame -> Players
calculatePlayers games =
    let
        playerList =
            calculatePlayerList games
    in
    Players
        (List.any hasRealName playerList)
        playerList


calculatePlayerList : List DecodedGame -> List Player
calculatePlayerList games =
    listScorers games
        |> List.foldl incrementGoals Dict.empty
        |> Dict.map (\playerIdTuple goals -> player (fromTuple playerIdTuple) goals)
        |> Dict.values
        |> List.filter hasRealName
        |> List.sortWith (by .goalCount DESC |> andThen playerName ASC |> andThen teamName ASC)


incrementGoals : PlayerId -> Dict ( String, String ) Int -> Dict ( String, String ) Int
incrementGoals playerId playerGoals =
    let
        currentGoals =
            Dict.get (toTuple playerId) playerGoals
                |> Maybe.withDefault 0
    in
    Dict.insert (toTuple playerId) (currentGoals + 1) playerGoals


listScorers : List DecodedGame -> List PlayerId
listScorers games =
    List.foldl addScorers [] games


addScorers : DecodedGame -> List PlayerId -> List PlayerId
addScorers game scorers =
    scorers
        ++ List.map (addScorer game.homeTeamName) game.homeTeamGoals
        ++ List.map (addScorer game.awayTeamName) game.awayTeamGoals


addScorer : String -> String -> PlayerId
addScorer teamName playerName =
    PlayerId teamName playerName
