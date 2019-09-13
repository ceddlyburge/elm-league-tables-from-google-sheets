module Calculations.PlayersFromLeagueGames exposing (calculatePlayers)

import Dict exposing (..)
import Models.Game exposing (Game)
import Models.Player exposing (..)
import Calculations.SortBy exposing (..)

-- Its annoying that I can't using PlayerId as a key to the Dict
-- and instead have to convert it to a tuple

-- Later players might contain other things, such as cards / penalties
-- Then we will probably store the players in a list in the model,
-- and provide functions to sort that list for the various atributes.
-- For now though, there is only one use case, so store the sorted 
-- list.
calculatePlayers: List Game -> Players
calculatePlayers games =
    Players False (calculatePlayerList games)

calculatePlayerList: List Game -> List Player
calculatePlayerList games =
    listScorers games 
    |> List.foldl incrementGoals Dict.empty
    |> Dict.map (\playerIdTuple goals -> Player (fromTuple playerIdTuple) goals)
    |> Dict.values
    |> List.filter hasPlayerName
    |> List.sortWith (by .goalCount DESC |> andThen playerName ASC |> andThen teamName ASC)


incrementGoals: PlayerId -> Dict (String, String) Int -> Dict (String, String) Int
incrementGoals playerId playerGoals =
    let
        currentGoals = 
            Dict.get (toTuple playerId) playerGoals
            |> Maybe.withDefault 0
    in
        Dict.insert (toTuple playerId) (currentGoals + 1) playerGoals

listScorers: List Game -> List PlayerId
listScorers games =
    List.foldl addScorers [] games

addScorers: Game -> List PlayerId -> List PlayerId
addScorers game scorers =
    scorers 
    ++ List.map (addScorer game.homeTeamName) game.homeGoals
    ++ List.map (addScorer game.awayTeamName) game.awayGoals

addScorer: String -> String ->  PlayerId
addScorer teamName playerName =
    PlayerId teamName playerName

hasPlayerName: Player -> Bool
hasPlayerName player =
    String.trim (playerName player) /= ""
