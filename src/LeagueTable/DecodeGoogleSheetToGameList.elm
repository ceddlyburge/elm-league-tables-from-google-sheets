module LeagueTable.DecodeGoogleSheetToGameList exposing (decodeSheetToGames)

import Json.Decode exposing (Decoder, at, list, string, succeed, index, int, value, Value, andThen, decodeString)
import Json.Decode.Extra exposing (parseInt, indexedList)
import Models.Game exposing (Game)


decodeSheetToGames : Decoder (List Game)
decodeSheetToGames =
    decodeSheetToMaybeGames
    |> Json.Decode.map (List.filterMap identity)

decodeSheetToMaybeGames : Decoder (List (Maybe Game))
decodeSheetToMaybeGames =
    Json.Decode.field "values" (indexedList decodeRowToGame)

-- skip header row
decodeRowToGame : Int -> Decoder (Maybe Game)
decodeRowToGame row =
    case row of
        0 ->
            succeed Maybe.Nothing
        _ ->
                Json.Decode.map8 
                    gameFromStrings  
                    (index 0 string)
                    (index 1 parseInt)
                    (index 3 string) -- this is on purpose
                    (index 2 parseInt)
                    (index 4 string)
                    (index 5 string)
                    (index 6 string)
                    (index 7 string)
                
gameFromStrings
    homeTeamName
    homeTeamGoals 
    awayTeamName 
    awayTeamGoals
    dateplayed 
    homeScorers
    awayScorers
    notesAndCards 
    =
    Just (
        Game 
        homeTeamName
        homeTeamGoals 
        awayTeamName 
        awayTeamGoals
        dateplayed 
        homeScorers
        awayScorers
        notesAndCards
    )
